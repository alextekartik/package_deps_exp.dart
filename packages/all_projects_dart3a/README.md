# all_projects_dart3a

A dependency resolution check, as [all_projects_main](../all_projects_main)
but on the `dart3a` branch of each package (`ref: dart3a`, a subset of the
main list), so that `dart pub get` proves those branches still resolve
together on the current SDK. Its Flutter twin is
[all_projects_flutter_dart3a](../all_projects_flutter_dart3a), which depends
on it.

Run by `repo_support/tool/run_ci.dart` (`pubGetOnly`). A failing `pub get`
here means a `dart3a` branch, or one of its constraints, no longer resolves:
fix the branch, or drop the package from the list.

There is no code: the `_tmp` section keeps the packages taken out of the list,
with the reason.
