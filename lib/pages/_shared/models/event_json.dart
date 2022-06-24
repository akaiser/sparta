import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

class EventsJson extends Equatable {
  const EventsJson({
    required this.day,
    required this.items,
  });

  factory EventsJson.fromJson(Map<String, dynamic> json) {
    return EventsJson(
      day: DateTime.parse(json['day'] as String),
      items: safeMap(json['items'] as Iterable, EventJson.fromJson),
    );
  }

  final DateTime day;
  final List<EventJson> items;

  @override
  List<Object?> get props => [day, items];
}

class EventJson extends Equatable {
  const EventJson({required this.id});

  factory EventJson.fromJson(Map<String, dynamic> json) {
    return EventJson(
      id: json['id'] as int,
    );
  }

  final int id;

  @override
  List<Object?> get props => [id];
}
