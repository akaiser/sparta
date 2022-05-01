import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
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
  late final StreamSubscription<DateTime> _eventsStateSubscription;

  DateTime get _pickerDate => widget.pickerDateNotifier.value;

  void _setPickerDate(newDate) => widget.pickerDateNotifier.value = newDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _eventsStateSubscription = StoreProvider.of<AppState>(context)
          .onChange
          .map((appState) => appState.eventsState)
          .distinct()
          .map((eventsState) => eventsState.focusedDate)
          .where((focusedDate) => !_pickerDate.isSameMonth(focusedDate))
          .listen((focusedDate) => _setPickerDate(focusedDate));
    });
  }

  @override
  void dispose() {
    _eventsStateSubscription.cancel();
    super.dispose();
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Center(
              child: ValueListenableBuilder<DateTime>(
                valueListenable: widget.pickerDateNotifier,
                builder: (context, pickerDate, _) {
                  return Text(
                    pickerDate.month.toMonth.l10n(context.l10n),
                    overflow: TextOverflow.ellipsis,
                    style: context.tt.bodyMedium,
                  );
                },
              ),
            ),
          ),
        ),
        HoverIconButton(
          Icons.chevron_right,
          onPressed: () => _setPickerDate(_pickerDate.addMonth),
        ),
        ValueListenableBuilder<DateTime>(
          valueListenable: widget.pickerDateNotifier,
          builder: (context, pickerDate, _) {
            return HoverIconButton(
              Icons.fiber_manual_record_outlined,
              onPressed: pickerDate.isSameMonth(DateTime.now())
                  ? null
                  : () => context
                      .dispatch(const FetchEventsAction(EventsActionType.init)),
            );
          },
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
                valueListenable: widget.pickerDateNotifier,
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
  }
}
