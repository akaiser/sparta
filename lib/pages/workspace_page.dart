import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/fade_in.dart';
import 'package:sparta/pages/_shared/ui/simple_split.dart';
import 'package:sparta/pages/workspace/left_view.dart';
import 'package:sparta/pages/workspace/right_view.dart';
import 'package:sparta/states/workspace_epic.dart';

class WorkspacePage extends StatefulWidget {
  const WorkspacePage({super.key});

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

class _WorkspacePageState extends State<WorkspacePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.store.dispatch(const InitWorkspaceAction()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ValueConnector<bool>(
            converter: (state) => state.settingsState.isLeftViewVisible,
            builder: (context, isLeftViewVisible, _) => FadeIn(
              child: SimpleSplit(
                left: const LeftView(),
                right: const RightView(),
                leftViewVisible: isLeftViewVisible,
                dividerBorderColor: context.td.dividerColor,
                initLeftWidth: 260,
              ),
            ),
          ),
        ),
      );
}
