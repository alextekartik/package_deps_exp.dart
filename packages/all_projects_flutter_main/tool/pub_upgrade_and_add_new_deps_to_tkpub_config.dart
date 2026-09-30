import 'package:dev_build/menu/menu_run_ci.dart';

import 'add_all_deps_to_tkpub_config.dart';

/// Upgrade the dependencies (git ones included) then add the new tekartik
/// git dependencies to the tkpub config.
Future<void> main() async {
  var pubIoPackage = PubIoPackage('.');
  await pubIoPackage.ready;
  await pubIoPackage.pubUpgrade();
  await addDeps('.');
}
