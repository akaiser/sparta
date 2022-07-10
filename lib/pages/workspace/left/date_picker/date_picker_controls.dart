import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/listenable_builder.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/states/events_state.dart';

class DatePickerControls extends StatefulWidget {
  const DatePickerControls(this.pickerDateNotifier, {super.key});

  final ValueNotifier<DateTime> pickerDateNotifier;

  @override
  State<DatePickerControls> createState() => _DatePickerControlsState();
}

class _DatePickerControlsState extends State<DatePickerControls> {
  DateTime get _pickerDate => widget.pickerDateNotifier.value;

  DateTime _updatePickerDate(DateTime newDate) =>
      widget.pickerDateNotifier.value = newDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.store.onChange
          .map((appState) => appState.focussedDateState)
          .distinct()
          .map((focussedDateState) => focussedDateState.focusedDate)
          .where((focusedDate) => !_pickerDate.isSameMonth(focusedDate))
          .listen(_updatePickerDate),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Row(
      children: [
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _updatePickerDate(_pickerDate.subtractMonth),
        ),
        Expanded(
          child: ListenableBuilder<DateTime, String>(
            widget.pickerDateNotifier,
            converter: (date) => date.month.toMonth.l10n(context.l10n),
            builder: (context, text, _) => _Text(text),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _updatePickerDate(_pickerDate.addMonth),
        ),
        ListenableBuilder<DateTime, bool>(
          widget.pickerDateNotifier,
          converter: (pickerDate) => pickerDate.isSameMonth(now),
          builder: (_, sameMonth, __) => _CircleButton(isSameMonth: sameMonth),
        ),
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _updatePickerDate(_pickerDate.subtractYear),
        ),
        Expanded(
          child: ListenableBuilder<DateTime, String>(
            widget.pickerDateNotifier,
            converter: (pickerDate) => '${pickerDate.year}',
            builder: (context, text, _) => _Text(text),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _updatePickerDate(_pickerDate.addYear),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({required this.isSameMonth});

  static const _initAction = FetchEventsAction(EventsActionType.init);

  final bool isSameMonth;

  @override
  Widget build(BuildContext context) {
    return HoverIconButton(
      Icons.fiber_manual_record_outlined,
      onPressed: isSameMonth ? null : () => context.store.dispatch(_initAction),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.tt.bodyMedium,
      textAlign: TextAlign.center,
      overflow: TextOverflow.fade,
      softWrap: false,
    );
  }
}
