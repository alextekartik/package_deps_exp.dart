# all_projects_flutter_dart2_3

A dependency resolution check, the Flutter twin of
[all_projects_dart2_3](../all_projects_dart2_3): it depends on the `dart2_3`
branch of the tekartik Flutter packages that keep one, so that
`flutter pub get` proves they still resolve together on the current SDK.

Run by `repo_support/tool/run_ci_flutter.dart` (`pubGetOnly`); the weekly
downgrade analyze workflow analyzes it too. A failing `pub get` here means a
`dart2_3` branch, or one of its constraints, no longer resolves: fix the
branch, or drop the package from the list.

`lib/main.dart` is a minimal app on `package:flutter/widgets.dart` only: no
material import (deprecated since Flutter 3.50) and no extra dependency that
would change the resolution checked.
