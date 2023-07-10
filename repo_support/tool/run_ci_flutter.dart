import 'package:dev_test/package.dart';
import 'package:path/path.dart';

Future main() async {
  for (var dir in [
    'all_projects_flutter_dart2_3',
    'all_projects_flutter_dart3a',
  ]) {
    await packageRunCi(join('..', 'packages', dir),
        options: PackageRunCiOptions(pubGetOnly: true));
  }
}
