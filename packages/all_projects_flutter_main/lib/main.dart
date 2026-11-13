// A dependency resolution check: the app only has to build. Flutter widgets
// only, no material import (deprecated since Flutter 3.50: `flutter analyze`
// fails on it) and no material_ui dependency, which would change the
// resolution checked.
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

/// The app: a single text.
class MyApp extends StatelessWidget {
  /// The app.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: Text('all_projects_flutter_main')),
    );
  }
}
