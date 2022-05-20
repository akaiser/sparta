import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/listenable_builder.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/states/events_state.dart';

class DatePickerControls extends StatefulWidget {
  const DatePickerControls(this.pickerDateNotifier, {Key? key})
      : super(key: key);

  final ValueNotifier<DateTime> pickerDateNotifier;

  @override
  State<DatePickerControls> createState() => _DatePickerControlsState();
}

class _DatePickerControlsState extends State<DatePickerControls> {
  DateTime get _pickerDate => widget.pickerDateNotifier.value;

  void _setPickerDate(newDate) => widget.pickerDateNotifier.value = newDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => context.store.onChange
        .map((appState) => appState.eventsState)
        .distinct()
        .map((eventsState) => eventsState.focusedDate)
        .where((focusedDate) => !_pickerDate.isSameMonth(focusedDate))
        .listen((focusedDate) => _setPickerDate(focusedDate)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _setPickerDate(_pickerDate.subtractMonth),
        ),
        Expanded(
          child: Center(
            child: ListenableBuilder<DateTime, String>(
              listenable: widget.pickerDateNotifier,
              converter: (date) => date.month.toMonth.l10n(context.l10n),
              builder: (context, text, _) => Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: context.tt.bodyMedium,
              ),
            ),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _setPickerDate(_pickerDate.addMonth),
        ),
        ListenableBuilder<DateTime, bool>(
          listenable: widget.pickerDateNotifier,
          converter: (pickerDate) => pickerDate.isSameMonth(DateTime.now()),
          builder: (_, sameMonth, __) => _CircleButton(isSameMonth: sameMonth),
        ),
        HoverIconButton(
          Icons.chevron_left,
          onPressed: () => _setPickerDate(_pickerDate.subtractYear),
        ),
        Expanded(
          child: Center(
            child: ListenableBuilder<DateTime, String>(
              listenable: widget.pickerDateNotifier,
              converter: (pickerDate) => '${pickerDate.year}',
              builder: (context, text, _) => Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: context.tt.bodyMedium,
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
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.isSameMonth,
    Key? key,
  }) : super(key: key);

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
