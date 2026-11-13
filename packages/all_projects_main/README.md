# all_projects_main

A dependency resolution check: it depends on the tip (default branch) of the
tekartik pure Dart packages (git dependencies, no Flutter SDK dependency), so
that `dart pub get` proves they still resolve together on the current SDK.
Its Flutter twin is [all_projects_flutter_main](../all_projects_flutter_main),
which depends on it.

Run by `repo_support/tool/run_ci.dart` (`pubGetOnly`). A failing `pub get`
here means a package, or one of its constraints, no longer resolves with the
others: fix the package, or drop it from the list.

There is no code: the `_tmp` section keeps the packages taken out of the list,
with the reason.
