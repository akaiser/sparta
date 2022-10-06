import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/visibility_connector.dart';
import 'package:sparta/pages/_shared/ui/fade_in.dart';
import 'package:sparta/pages/workspace/right/day_names.dart';
import 'package:sparta/pages/workspace/right/days.dart';
import 'package:sparta/pages/workspace/right/top_bar.dart';

class RightView extends StatelessWidget {
  const RightView({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: context.td.scaffoldBackgroundColor,
        child: Stack(
          children: const [
            _Body(),
            _LoadingOverlay(),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => Column(
        children: const [
          Padding(
            padding: EdgeInsets.fromLTRB(9, 8, 8, 8),
            child: TopBar(),
          ),
          verticalDivider,
          SizedBox(height: 8),
          DayNames(),
          SizedBox(height: 8),
          Expanded(child: Days()),
        ],
      );
}

class _LoadingOverlay extends StatelessWidget {
  const _LoadingOverlay();

  @override
  Widget build(BuildContext context) => VisibilityConnector(
        visible: (state) => state.dayEventsState.isLoading,
        builder: (context) => const SizedBox.expand(
          child: FadeIn(
            child: ColoredBox(
              color: Color.fromRGBO(0, 0, 0, 0.25),
            ),
          ),
        ),
      );
}
