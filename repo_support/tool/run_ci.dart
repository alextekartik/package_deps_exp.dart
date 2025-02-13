import 'package:dev_build/package.dart';
import 'package:path/path.dart';
import 'package:process_run/shell.dart';
import 'package:pub_semver/pub_semver.dart';

Future main() async {
  for (var dir in ['all_projects_dart2_3']) {
    await packageRunCi(
      join('..', 'packages', dir),
      options: PackageRunCiOptions(pubGetOnly: true),
    );
  }
  if (dartVersion >= Version(3, 0, 0)) {
    for (var dir in ['all_projects_dart3a']) {
      await packageRunCi(
        join('..', 'packages', dir),
        options: PackageRunCiOptions(pubGetOnly: true),
      );
    }
  }
}
