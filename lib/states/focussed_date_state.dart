import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/extensions/events.dart';
import 'package:sparta/states/events_state.dart';

class FocusDateAction extends Equatable {
  const FocusDateAction(
    this.date, {
    this.checkShownEvents = false,
  });

  final DateTime date;
  final bool checkShownEvents;

  @override
  List<Object?> get props => [date, checkShownEvents];
}

FocussedDateState focussedDateStateReducer(
  FocussedDateState old,
  dynamic action,
) {
  if (action is FocusDateAction) {
    return FocussedDateState(focusedDate: action.date);
  }
  // foreign
  else if (action is FetchEventsAction) {
    if (action.actionType == EventsActionType.init) {
      return const FocussedDateState();
    }
  }
  return old;
}

TypedAppEpic<FocusDateAction> focusDateEpic() => TypedAppEpic<FocusDateAction>(
      (actions, store) => actions //
          .where((action) => action.checkShownEvents)
          .asyncMap((action) {
        final overrideDate = action.date;
        final eventsState = store.state.eventsState;
        final dateIsShown = eventsState.events.shownEventsContainDate(
          eventsState.refDate,
          overrideDate,
        );
        if (!dateIsShown) {
          return FetchEventsAction(
            EventsActionType.picker,
            overriddenRefDate: overrideDate,
          );
        }
      }),
    );

class FocussedDateState extends Equatable {
  const FocussedDateState({
    DateTime? focusedDate,
  }) : _focusedDate = focusedDate;

  final DateTime? _focusedDate;

  DateTime get focusedDate => (_focusedDate ?? DateTime.now()).midDay;

  @override
  List<Object?> get props => [focusedDate];
}
