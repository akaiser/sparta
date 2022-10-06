import 'package:equatable/equatable.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/models/day_event_model.dart';
import 'package:sparta/pages/_shared/network/days_http_client.dart';
import 'package:sparta/pages/_shared/util/try_and_catch.dart';
import 'package:sparta/states/_day_events_ref_date_ex.dart';
import 'package:sparta/states/workspace_epic.dart';

enum DayEventsActionType {
  init,
  picker,
  nextWeek,
  previousWeek,
}

abstract class _DayEventsAction extends Equatable {
  const _DayEventsAction();
}

class FetchDayEventsAction extends _DayEventsAction {
  const FetchDayEventsAction(
    this.actionType, {
    this.overriddenRefDate,
  });

  final DayEventsActionType actionType;
  final DateTime? overriddenRefDate;

  @override
  List<Object?> get props => [actionType, overriddenRefDate];
}

class ResultFetchDayEventsAction extends _DayEventsAction {
  const ResultFetchDayEventsAction(this.dayEvents);

  final Map<DateTime, Iterable<DayEventModel>> dayEvents;

  @override
  List<Object?> get props => [dayEvents];
}

class ErrorFetchDayEventsAction extends _DayEventsAction {
  const ErrorFetchDayEventsAction(this.exception);

  final Exception exception;

  @override
  List<Object?> get props => [exception];
}

bool _shouldLoadAndFetch(
  DateTime? refDate,
  DayEventsActionType actionType,
  Map<DateTime, Iterable<DayEventModel>> dayEvents,
) {
  if (refDate != null) {
    final startDate = refDate.toFetchStartDate(actionType).midDay;
    final endDate = refDate.toFetchEndDate(actionType).midDay;
    if (dayEvents[startDate] != null && dayEvents[endDate] != null) {
      return false;
    }
  }
  return true;
}

DayEventsState dayEventsStateReducer(DayEventsState old, dynamic action) {
  // #foreign
  if (action is InitWorkspaceAction) {
    return const DayEventsState(isLoading: true);
  }

  if (action is _DayEventsAction) {
    if (action is FetchDayEventsAction) {
      final actionType = action.actionType;
      final newRefDate = action.overriddenRefDate ??
          old.refDate.toNewRefDate(actionType)?.midDay;
      return DayEventsState(
        refDate: newRefDate,
        dayEvents: old.dayEvents,
        isLoading: _shouldLoadAndFetch(newRefDate, actionType, old.dayEvents),
      );
    } else if (action is ResultFetchDayEventsAction) {
      return DayEventsState(
        refDate: old.refDate,
        dayEvents: {...old.dayEvents, ...action.dayEvents},
      );
    } else if (action is ErrorFetchDayEventsAction) {
      // TODO(albert): handle errors in views
      return DayEventsState(
        refDate: old.refDate,
        exception: action.exception,
      );
    }
  }
  return old;
}

TypedAppEpic<FetchDayEventsAction> fetchDaysEpic(DaysHttpClient http) =>
    TypedAppEpic<FetchDayEventsAction>(
      (actions, store) => actions
          .where((_) => store.state.dayEventsState.isLoading)
          .map((action) => action.actionType)
          .asyncMap<_DayEventsAction>(
            (actionType) => tryAndCatch(
              () async {
                final refDate = store.state.dayEventsState.refDate;
                final json = await http.fetchDays(
                  from: refDate.toFetchStartDate(actionType),
                  to: refDate.toFetchEndDate(actionType),
                );

                final calendars = store.state.calendarsState.calendars;
                final categories = store.state.categoriesState.categories;
                final dayEvents = {
                  for (final dayJson in json)
                    dayJson.date.midDay: dayJson.dayEvents.map(
                      (dayEventJson) => DayEventModel(
                        id: dayEventJson.id,
                        calendar: calendars.firstWhere(
                          (calendar) => calendar.id == dayEventJson.calenderId,
                        ),
                        categories: dayEventJson.categoryIds.map(
                          (categoryId) => categories.singleWhere(
                            (category) => category.id == categoryId,
                          ),
                        ),
                      ),
                    )
                };
                return ResultFetchDayEventsAction(dayEvents);
              },
              ErrorFetchDayEventsAction.new,
            ),
          ),
    );

class DayEventsState extends Equatable {
  const DayEventsState({
    DateTime? refDate,
    this.dayEvents = const {},
    this.exception,
    this.isLoading = false,
  }) : _refDate = refDate;

  final DateTime? _refDate;
  final Map<DateTime, Iterable<DayEventModel>> dayEvents;
  final Exception? exception;
  final bool isLoading;

  DateTime get refDate => (_refDate ?? DateTime.now()).midDay;

  bool shownEventsContainDate(DateTime date) =>
      shownDayEvents.keys.contains(date);

  Map<DateTime, Iterable<DayEventModel>> get shownDayEvents {
    final filtered = <DateTime, Iterable<DayEventModel>>{};
    for (var i = 0; i < 14; i++) {
      final day = refDate.startOfWeek.add(Duration(days: i));

      // TODO(albert): try with groupBy Ext
      final entry = dayEvents.entries.singleWhere(
        (it) => it.key.isSameDay(day),
        orElse: () => MapEntry(day, const []),
      );
      filtered[entry.key] = entry.value;
    }
    return filtered;
  }

  @override
  List<Object?> get props => [
        refDate,
        dayEvents,
        exception,
        isLoading,
      ];
}
