import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/simple_split_view.dart';
import 'package:sparta/pages/workspace/left_view.dart';
import 'package:sparta/pages/workspace/right_view.dart';

class WorkspacePage extends StatelessWidget {
  const WorkspacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueConnector<bool>(
          converter: (state) => state.settingsState.isLeftViewVisible,
          builder: (context, isLeftViewVisible) {
            return SimpleSplitView(
              left: const LeftView(),
              right: const RightView(),
              dividerWidth: splitDividerWidth,
              dividerColor: context.td.dividerColor,
              leftViewVisible: isLeftViewVisible,
            );
          },
        ),
      ),
    );
  }
}
