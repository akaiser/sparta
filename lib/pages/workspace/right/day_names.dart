import 'package:flutter/widgets.dart';
import 'package:sparta/l10n/mappers/week_day.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class DayNames extends StatelessWidget {
  const DayNames({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isWorkWeek,
      builder: (context, isWorkWeek, _) => Row(
        children: WeekDay.values
            .take(isWorkWeek ? 5 : 7)
            .map(
              (weekDay) => Expanded(
                child: Center(
                  child: Text(
                    weekDay.l10n(context.l10n),
                    style: context.tt.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
            .toUnmodifiableList,
      ),
    );
  }
}
