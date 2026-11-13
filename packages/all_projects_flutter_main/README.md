# all_projects_flutter_main

A dependency resolution check: it depends on the tip (default branch) of the
tekartik Flutter packages (git dependencies) and on the latest published
tekartik packages (hosted, with a floor), so that `flutter pub get` proves
they still resolve together on the current Flutter SDK. It depends on its
pure Dart twin [all_projects_main](../all_projects_main): a pure Dart package
goes in that list, a package needing Flutter in this one.

Run by `repo_support/tool/run_ci_flutter.dart` (`pubGetOnly`, Flutter stable
and beta) and by the downgrade analyze workflow. A failing `pub get` here
means a package, or one of its constraints, no longer resolves with the
others: fix the package, or drop it from the list.

`lib/main.dart` is a minimal app (Flutter widgets only): the package only has
to resolve and analyze. The `_dependency_overrides` section is off (the key
pub reads is `dependency_overrides`); rename it to use local versions.

`tool/write_ddeps.dart` writes the dependency tree in `doc/` (`ddeps list`,
plain or `--tekartik`, text or `--json`).
