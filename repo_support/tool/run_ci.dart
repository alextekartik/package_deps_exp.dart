import 'dart:io';

import 'package:dev_test/package.dart';
import 'package:path/path.dart';

Future main() async {
  for (var dir in [
    if (!Platform.isWindows) 'all_projects_dart2',
    if (!Platform.isWindows) 'all_projects_null_safety',
    'all_projects_dart2_3',
  ]) {
    await packageRunCi(join('..', 'packages', dir),
        options: PackageRunCiOptions(pubGetOnly: true));
  }
}
