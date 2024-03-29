import 'package:flutter/widgets.dart';
import 'package:sparta/l10n/mappers/week_day.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class DayNames extends StatelessWidget {
  const DayNames({super.key});

  @override
  Widget build(BuildContext context) => ValueConnector<bool>(
        converter: (state) => state.settingsState.isWorkWeek,
        builder: (context, isWorkWeek, _) => Row(
          children: WeekDay.values
              .take(isWorkWeek ? 5 : 7)
              .map(
                (weekDay) => Expanded(
                  child: Text(
                    weekDay.l10n(context.l10n),
                    style: context.tt.subtitle2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              )
              .unmodifiable,
        ),
      );
}
