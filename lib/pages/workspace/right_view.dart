import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/state/visibility_connector.dart';
import 'package:sparta/pages/_shared/ui/fade_in.dart';
import 'package:sparta/pages/workspace/right/day_names.dart';
import 'package:sparta/pages/workspace/right/days.dart';
import 'package:sparta/pages/workspace/right/top_bar.dart';

class RightView extends StatelessWidget {
  const RightView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BUILD_RightView');
    return Stack(
      children: [
        Column(
          children: const [
            TopBar(),
            Divider(height: 1, thickness: sectionsDividerThickness),
            DayNames(),
            Expanded(child: Days()),
          ],
        ),
        VisibilityConnector(
          visible: (state) => state.eventsState.isLoading,
          builder: (context) => const FadeIn(
            child: ColoredBox(
              color: Color.fromRGBO(0, 0, 0, 0.3),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ],
    );
  }
}
