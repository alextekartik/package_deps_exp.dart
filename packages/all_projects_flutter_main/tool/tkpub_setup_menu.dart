import 'package:dev_build/menu/menu_io.dart';
import 'package:tekartik_prj_tktools/tkpub.dart';

Future<TkPubDbPackage> addGitPackage(
  String packageName, {
  required String gitUrl,
  String? gitPath,
}) async {
  return await tkPubDbAction((configDb) async {
    var package = TkPubDbPackage()
      ..gitUrl.v = gitUrl
      ..gitPath.setValue(gitPath);

    var added = await configDb.setPackage(packageName, package);
    return added;
  }, write: true);
}

Future<void> main(List<String> args) async {
  mainMenuConsole(args, () {
    menu('once', () {
      item('tekartik_prj_tools', () async {
        writeln(
          await addGitPackage(
            'tekartik_prj_tools',
            gitUrl: 'git@github.com:tekartikprv/tools.dart',
            gitPath: 'packages/prj_tools',
          ),
        );
      });
      item('list', () async {
        await tkPubDbAction((configDb) async {
          var packages = await configDb.getAllPackages();

          for (var package in packages) {
            writeln(package);
          }
        });
      });
      item('setup vertex ai', () async {
        await tkPubDbAction(
          (configDb) async {
            var gitUrl = 'https://github.com/tekartik/firebase_vertex_ai.dart';
            var package = TkPubDbPackage()
              ..gitUrl.v = gitUrl
              ..gitPath.v = 'vertex_ai';

            package = await configDb.setPackage(
              'tekartik_firebase_vertex_ai',
              package,
            );
            write(package);
            gitUrl = 'https://github.com/tekartik/firebase_flutter';
            package = TkPubDbPackage()
              ..gitUrl.v = gitUrl
              ..gitPath.v = 'vertex_ai_flutter';

            package = await configDb.setPackage(
              'tekartik_firebase_vertex_ai_flutter',
              package,
            );

            write(package);
          },
          write: true,
          verbose: true,
        );
      });
    });
  });
}
