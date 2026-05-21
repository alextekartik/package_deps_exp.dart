import 'dart:io';
import 'package:tekartik_common_utils/version_utils.dart';
import 'package:dev_build/build_support.dart';
import 'package:dev_build/menu/menu_run_ci.dart';
import 'package:path/path.dart';
import 'package:tekartik_prj_tktools/dtk/dtk_dep.dart';

Future<void> main() async {
  var path = '.';
  var pubIoPackage = PubIoPackage(path);
  var packageConfigMap = await pubIoPackage.cachedOrGetPackageConfigMap();
  var packages = packageConfigGetPackages(packageConfigMap);
  var versionMap = <String, Version>{};
  for (var package in packages) {
    //stdout.writeln(package);
    var packagePath = (await pubIoPackage.getResolvedPackagePath(package))!;
    // hosted?
    if (packagePath.contains(join('hosted', 'pub.dev'))) {
      var dependencyPubspecYaml = await pathGetPubspecYamlMap(packagePath);
      var version = pubspecYamlGetVersion(dependencyPubspecYaml);
      // stdout.writeln('$package: $version');
      versionMap[package] = version;
    }
  }
  late List<DbDtkDepDependency> dependencies;
  await dtkDepConfigDbAction((configDb) async {
    dependencies = await configDb.getAllDependencies();
    for (var package in dependencies.map((e) => e.id)) {
      var newVersion = versionMap[package];
      if (newVersion != null) {
        var dep =
            (await configDb.getDependencyOrNull(package)) ??
            (DbDtkDepDependency()..minVersion.v = Version(0, 0, 0).toString());
        var currentMinVersion = Version.parse(dep.minVersion.v!);
        if (newVersion > currentMinVersion) {
          stdout.writeln('$package: $currentMinVersion -> $newVersion');
          dep.minVersion.v = newVersion.toString();
          configDb.setDependency(package, dep);
        }
      }
    }
  }, write: true);
}
