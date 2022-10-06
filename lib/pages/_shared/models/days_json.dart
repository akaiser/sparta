import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

class DaysJson extends Equatable {
  const DaysJson._({required this.days});

  factory DaysJson.fromJson(Map<String, dynamic> json) => DaysJson._(
        days: safeMap(
          json['days'] as Iterable,
          DayJson.fromJson,
        ),
      );

  final List<DayJson> days;

  @override
  List<Object?> get props => [days];
}

class DayJson extends Equatable {
  const DayJson._({
    required this.date,
    required this.dayEvents,
  });

  factory DayJson.fromJson(Map<String, dynamic> json) => DayJson._(
        date: DateTime.parse(json['date'] as String),
        dayEvents: safeMap(
          json['day_events'] as Iterable,
          DayEventJson.fromJson,
        ),
      );

  final DateTime date;
  final List<DayEventJson> dayEvents;

  @override
  List<Object?> get props => [date, dayEvents];
}

class DayEventJson extends Equatable {
  const DayEventJson._({
    required this.id,
    required this.calenderId,
    required this.categoryIds,
  });

  factory DayEventJson.fromJson(Map<String, dynamic> json) => DayEventJson._(
        id: json['id'] as String,
        calenderId: json['calender_id'] as String,
        categoryIds: json['category_ids'] as List<String>,
      );

  final String id;

  final String calenderId;
  final List<String> categoryIds;

  @override
  List<Object?> get props => [id, calenderId, categoryIds];
}
