# all_projects_flutter_dart3a

A dependency resolution check, as
[all_projects_flutter_main](../all_projects_flutter_main) but on the `dart3a`
branch of each package (`ref: dart3a`, a subset of the main list), so that
`flutter pub get` proves those branches still resolve together on the current
Flutter SDK. It depends on its pure Dart twin
[all_projects_dart3a](../all_projects_dart3a): a pure Dart package goes in
that list, a package needing Flutter in this one.

Run by `repo_support/tool/run_ci_flutter.dart` (`pubGetOnly`, Flutter stable
and beta) and by the downgrade analyze workflow. A failing `pub get` here
means a `dart3a` branch, or one of its constraints, no longer resolves: fix
the branch, or drop the package from the list.

`lib/main.dart` is a minimal app (Flutter widgets only): the package only has
to resolve and analyze. `dependency_overrides` pins the published packages to
their `dart3a` branch; `_pubspec_overrides.yaml` is an inactive copy (rename
it `pubspec_overrides.yaml` to use it locally).
