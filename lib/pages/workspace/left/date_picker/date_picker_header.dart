import 'package:flutter/widgets.dart';
import 'package:sparta/l10n/mappers/week_day.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';

class DatePickerHeader extends StatelessWidget {
  const DatePickerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36),
      child: Row(
        children: WeekDay.values
            .map(
              (weekDay) => Expanded(
                child: Text(
                  weekDay.l10nShort(context.l10n),
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.subtitle2,
                  textAlign: TextAlign.center,
                ),
              ),
            )
            .toUnmodifiableList,
      ),
    );
  }
}
