import 'package:equatable/equatable.dart';

class FocusDayEventAction extends Equatable {
  const FocusDayEventAction(this.dayEventId);

  final String dayEventId;

  @override
  List<Object?> get props => [dayEventId];
}

FocussedDayEventState focussedEventStateReducer(
  FocussedDayEventState old,
  dynamic action,
) {
  if (action is FocusDayEventAction) {
    return FocussedDayEventState(dayEventId: action.dayEventId);
  }
  return old;
}

class FocussedDayEventState extends Equatable {
  const FocussedDayEventState({this.dayEventId});

  final String? dayEventId;

  @override
  List<Object?> get props => [dayEventId];
}
