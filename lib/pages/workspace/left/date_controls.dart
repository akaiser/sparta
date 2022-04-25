import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';

class DateControls extends StatelessWidget {
  const DateControls(this.refDateNotifier, {Key? key}) : super(key: key);

  final ValueNotifier<DateTime> refDateNotifier;

  void _updateRefDate(DateTime refDate) {
    refDateNotifier.value = refDate;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      children: [
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _updateRefDate(refDateNotifier.value.subtractMonth),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Center(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: refDateNotifier,
                builder: (context, refDate, _) => Text(
                  refDate.month.toMonth.l10n(context.l10n),
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.bodyMedium,
                ),
              ),
            ),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _updateRefDate(refDateNotifier.value.addMonth),
        ),
        ValueListenableBuilder<DateTime>(
          valueListenable: refDateNotifier,
          builder: (context, refDate, _) => HoverIconButton(
            Icons.fiber_manual_record_outlined,
            onPressed: refDate.isSameDay(now)
                ? null
                : () => _updateRefDate(DateTime.now().midDay),
          ),
        ),
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _updateRefDate(refDateNotifier.value.subtractYear),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Center(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: refDateNotifier,
                builder: (context, refDate, _) => Text(
                  '${refDate.year}',
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.bodyMedium,
                ),
              ),
            ),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _updateRefDate(refDateNotifier.value.addYear),
        ),
      ],
    );
  }
}
