import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

class CalendarsJson extends Equatable {
  const CalendarsJson._({required this.calendars});

  factory CalendarsJson.fromJson(Map<String, dynamic> json) => CalendarsJson._(
        calendars: safeMap(
          json['calendars'] as List,
          CalendarJson.fromJson,
        ),
      );

  final List<CalendarJson> calendars;

  @override
  List<Object?> get props => [calendars];
}

class CalendarJson extends Equatable {
  const CalendarJson._({
    required this.id,
    required this.title,
    required this.color,
  });

  factory CalendarJson.fromJson(Map<String, dynamic> json) => CalendarJson._(
        id: json['id'] as String,
        title: json['title'] as String,
        color: json['color'] as String,
      );

  final String id;
  final String title;
  final String color;

  @override
  List<Object?> get props => [id, title, color];
}
