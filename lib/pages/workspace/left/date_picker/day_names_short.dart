import 'package:flutter/widgets.dart';
import 'package:sparta/l10n/mappers/week_day.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';

class DayNamesShort extends StatelessWidget {
  const DayNamesShort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: WeekDay.values
          .map(
            (weekDay) => Expanded(
              child: Center(
                child: Text(
                  weekDay.l10nShort(context.l10n),
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.subtitle2,
                ),
              ),
            ),
          )
          .toUnmodifiableList,
    );
  }
}
