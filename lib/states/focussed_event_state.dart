import 'package:equatable/equatable.dart';

class FocusEventAction extends Equatable {
  const FocusEventAction(this.eventId);

  final int eventId;

  @override
  List<Object?> get props => [eventId];
}

FocussedEventState focussedEventStateReducer(
  FocussedEventState old,
  dynamic action,
) {
  if (action is FocusEventAction) {
    return FocussedEventState(eventId: action.eventId);
  }
  return old;
}

class FocussedEventState extends Equatable {
  const FocussedEventState({this.eventId});

  final int? eventId;

  @override
  List<Object?> get props => [eventId];
}
