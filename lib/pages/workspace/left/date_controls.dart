import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';

class DateControls extends StatelessWidget {
  const DateControls(this.pickerDateNotifier, {Key? key}) : super(key: key);

  final ValueNotifier<DateTime> pickerDateNotifier;

  void _updatePickerDate(DateTime pickerDate) {
    pickerDateNotifier.value = pickerDate;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      children: [
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () =>
              _updatePickerDate(pickerDateNotifier.value.subtractMonth),
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
          onPressed: () => _updatePickerDate(pickerDateNotifier.value.addMonth),
        ),
        ValueListenableBuilder<DateTime>(
          valueListenable: pickerDateNotifier,
          builder: (context, pickerDate, _) => HoverIconButton(
            Icons.fiber_manual_record_outlined,
            onPressed: pickerDate.isSameDay(now)
                ? null
                : () => _updatePickerDate(DateTime.now().midDay),
          ),
        ),
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () =>
              _updatePickerDate(pickerDateNotifier.value.subtractYear),
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
          onPressed: () => _updatePickerDate(pickerDateNotifier.value.addYear),
        ),
      ],
    );
  }
}
