import 'package:flutter/widgets.dart';
import 'package:sparta/pages/workspace_page.dart';

class StartupPage extends StatelessWidget {
  const StartupPage({super.key});

  @override
  Widget build(BuildContext context) =>
      // TODO(albert): plugin StartupState and/or UserState here
      // and decide to show LoginPage or Loading states with WorkspacePage
      // if: login then LoginPage -> todo
      // else:
      // - fade in WorkspacePage
      // -- then fetch calendars in the calendars section (loading, fade in)
      // -- then continue to fetch of categories
      //
      // - fetch categories, calendars in parallel
      // - then present WorkspacePage cause that one depends on them
      // - present LoadingIndicator
      // BUT: what if we have to update categories and calendars via admin later
      // - notify all clients to refresh
      const WorkspacePage();
}
