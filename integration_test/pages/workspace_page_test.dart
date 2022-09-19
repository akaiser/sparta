import 'package:flutter_test/flutter_test.dart';
import 'package:sparta/_settings.dart';
import 'package:sparta/main.dart';
import 'package:sparta/pages/workspace_page.dart';

void main() {
  testWidgets('shows $WorkspacePage', (tester) async {
    await Settings.init();

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(WorkspacePage), findsOneWidget);
  });
}
