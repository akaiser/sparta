import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';

class DatePickerControls extends StatelessWidget {
  const DatePickerControls(this.pickerDateNotifier, {Key? key})
      : super(key: key);

  final ValueNotifier<DateTime> pickerDateNotifier;

  DateTime get _pickerDate => pickerDateNotifier.value;

  void _setPickerDate(DateTime newDate) => pickerDateNotifier.value = newDate;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return ValueConnector<DateTime>(
      converter: (state) => state.eventsState.focusedDate,
      ignoreChange: (state) {
        final focusedDate = state.eventsState.focusedDate;
        if (!focusedDate.isSameMonth(_pickerDate)) {
          _setPickerDate(focusedDate);
        }
        return true;
      },
      builder: (context, _) {
        return Row(
          children: [
            HoverIconButton(
              Icons.chevron_left,
              onPressed: () => _setPickerDate(_pickerDate.subtractMonth),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Center(
                  child: ValueListenableBuilder<DateTime>(
                    valueListenable: pickerDateNotifier,
                    builder: (context, pickerDate, _) => Text(
                      pickerDate.month.toMonth.l10n(context.l10n),
                      overflow: TextOverflow.ellipsis,
                      style: context.tt.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            HoverIconButton(
              Icons.chevron_right,
              onPressed: () => _setPickerDate(_pickerDate.addMonth),
            ),
            ValueListenableBuilder<DateTime>(
              valueListenable: pickerDateNotifier,
              builder: (context, pickerDate, _) => HoverIconButton(
                Icons.fiber_manual_record_outlined,
                onPressed: pickerDate.isSameMonth(now)
                    ? null
                    : () => _setPickerDate(DateTime.now().midDay),
              ),
            ),
            HoverIconButton(
              Icons.chevron_left,
              onPressed: () => _setPickerDate(_pickerDate.subtractYear),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Center(
                  child: ValueListenableBuilder<DateTime>(
                    valueListenable: pickerDateNotifier,
                    builder: (context, pickerDate, _) => Text(
                      '${pickerDate.year}',
                      overflow: TextOverflow.ellipsis,
                      style: context.tt.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
            HoverIconButton(
              Icons.chevron_right,
              onPressed: () => _setPickerDate(_pickerDate.addYear),
            ),
          ],
        );
      },
    );
  }
}
