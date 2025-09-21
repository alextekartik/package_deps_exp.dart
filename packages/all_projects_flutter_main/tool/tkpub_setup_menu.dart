import 'package:dev_build/menu/menu_io.dart';
import 'package:tekartik_prj_tktools/tkpub.dart';

Future<void> main(List<String> args) async {
  mainMenuConsole(args, () {
    menu('once', () {
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
