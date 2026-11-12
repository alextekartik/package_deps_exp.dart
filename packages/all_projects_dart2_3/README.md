# all_projects_dart2_3

A dependency resolution check, no code: it depends on the `dart2_3` branch
of the tekartik Dart packages that keep one, so that `dart pub get` proves
they still resolve together on the current SDK.

Run by `repo_support/tool/run_ci.dart` (`pubGetOnly`). A failing `pub get`
here means a `dart2_3` branch, or one of its constraints, no longer
resolves: fix the branch, or drop the package from the list.

The `_tmp:` block of `pubspec.yaml` is ignored by pub (a parked entry).
