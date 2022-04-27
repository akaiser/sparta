import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/visibility_connector.dart';
import 'package:sparta/pages/_shared/ui/loading_overlay.dart';
import 'package:sparta/pages/workspace/right/day_names.dart';
import 'package:sparta/pages/workspace/right/days.dart';
import 'package:sparta/pages/workspace/right/top_bar.dart';

class RightView extends StatelessWidget {
  const RightView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.td.scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(9, 8, 8, 8),
                child: TopBar(),
              ),
              verticalDivider,
              DayNames(),
              Expanded(child: Days()),
            ],
          ),
          VisibilityConnector(
            visible: (state) => state.eventsState.isLoading,
            builder: (context) => const LoadingOverlay(),
          ),
        ],
      ),
    );
  }
}
