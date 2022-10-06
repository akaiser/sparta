import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/states/day_events_state.dart';

class FocusDayAction extends Equatable {
  const FocusDayAction(
    this.date, {
    this.checkShownDayEvents = false,
  });

  final DateTime date;
  final bool checkShownDayEvents;

  @override
  List<Object?> get props => [date, checkShownDayEvents];
}

FocussedDayState focussedDayStateReducer(
  FocussedDayState old,
  dynamic action,
) {
  // #foreign
  if (action is FetchDayEventsAction) {
    if (action.actionType == DayEventsActionType.init) {
      return const FocussedDayState();
    }
  }

  if (action is FocusDayAction) {
    return FocussedDayState(focusedDate: action.date);
  }
  return old;
}

TypedAppEpic<FocusDayAction> focusDayEpic() => TypedAppEpic<FocusDayAction>(
      (actions, store) => actions //
          .where((action) => action.checkShownDayEvents)
          .map((action) {
        final overrideDate = action.date;
        final dayEventsState = store.state.dayEventsState;
        final dateIsShown = dayEventsState.shownEventsContainDate(overrideDate);
        if (!dateIsShown) {
          return FetchDayEventsAction(
            DayEventsActionType.picker,
            overriddenRefDate: overrideDate,
          );
        }
      }).where((event) => event != null),
    );

class FocussedDayState extends Equatable {
  const FocussedDayState({
    DateTime? focusedDate,
  }) : _focusedDate = focusedDate;

  final DateTime? _focusedDate;

  DateTime get focusedDate => (_focusedDate ?? DateTime.now()).midDay;

  @override
  List<Object?> get props => [focusedDate];
}
