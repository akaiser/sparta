import 'package:flutter_test/flutter_test.dart';
import 'package:sparta/_prefs.dart';
import 'package:sparta/main.dart';
import 'package:sparta/pages/workspace_page.dart';

void main() {
  testWidgets('shows $WorkspacePage', (tester) async {
    await Prefs.init();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(WorkspacePage), findsOneWidget);
  });
}
