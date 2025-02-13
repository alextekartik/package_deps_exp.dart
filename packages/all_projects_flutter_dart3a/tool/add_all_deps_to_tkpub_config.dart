import 'dart:io';
import 'package:process_run/shell.dart';
import 'package:collection/collection.dart';
import 'package:dev_build/build_support.dart';

class Helper {
  /// If false new only
  final bool addAll;
  var globalMap = <String, Map>{};

  Helper({this.addAll = false});

  Future<void> addGlobalToTkpubConfig() async {
    List<String>? existing;
    if (!addAll) {
      existing =
          (await run(
            'tkpub config list',
          )).outLines.map((line) => line.split(' ').first).toList();
    }
    for (var entry in globalMap.entries) {
      if (existing != null && existing.contains(entry.key)) {
        continue;
      }
      // print('${entry.key}: ${entry.value}');
      var url = entry.value['url'];
      var path = entry.value['path'];
      if (url != null) {
        await run(
          'tkpub config set ${entry.key} --git-url $url${path != null ? ' --git-path $path' : ''}',
        );
      }
    }
  }

  Future<void> handlePath(String path) async {
    void addGlobal(String name, {required String gitUrl, String? gitPath}) {
      var existing = globalMap[name];
      var newValue = {'url': gitUrl, 'path': gitPath};
      if (existing != null) {
        if (!const DeepCollectionEquality().equals(existing, newValue)) {
          stderr.writeln('Conflict for $name:');
          stderr.writeln(' existing: $existing');
          stderr.writeln(' new: $newValue');
          stderr.writeln(' at path: $path');
          throw 'Conflict for $name: $existing != $newValue';
        }
      }
      // print('Adding $name: $newValue');
      globalMap[name] = newValue;
    }

    var pubspecMap = await pathGetPubspecYamlMap(path);

    var deps = pubspecMap['dependencies'] as Map?;
    var devDeps = pubspecMap['dev_dependencies'] as Map?;
    var dependencyOveriddes = pubspecMap['dependency_overrides'] as Map?;

    for (var dep in [deps, devDeps, dependencyOveriddes].nonNulls) {
      for (var entry in dep.entries) {
        var name = entry.key;
        var value = entry.value;
        if (value is Map) {
          var git = value['git'];
          if (git is Map) {
            var gitUrl = git['url'] as String?;
            var gitRef = git['ref'] as String?;
            var gitPath = git['path'] as String?;
            if (gitRef == 'dart3a') {
              // print('$name git: $git');
              addGlobal(name, gitUrl: gitUrl!, gitPath: gitPath);
            }
          }
        }
      }
    }
  }
}

Future<void> main() async {
  addDeps('.', addAll: true);
}

Future<void> addDeps(String path, {bool addAll = false}) async {
  var path = '.';

  var helper = Helper(addAll: addAll);

  await helper.handlePath('.');
  var packageConfigMap = await pathGetPackageConfigMap(path);
  var packages = packageConfigGetPackages(packageConfigMap);
  for (var package in packages) {
    var path = pathPackageConfigMapGetPackagePath(
      '.',
      packageConfigMap,
      package,
    );
    if (path != null) {
      await helper.handlePath(path);
    }
  }

  helper.addGlobalToTkpubConfig();
}
