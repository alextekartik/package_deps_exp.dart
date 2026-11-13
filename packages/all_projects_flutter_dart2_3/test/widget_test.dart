import 'package:all_projects_flutter_dart2_3/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('the app builds', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('all_projects_flutter_dart2_3'), findsOneWidget);
  });
}
