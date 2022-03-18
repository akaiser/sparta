import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/util/safe_map.dart';

class EventsJson extends Equatable {
  const EventsJson({
    required this.day,
    required this.items,
  });

  factory EventsJson.fromJson(Map<String, dynamic> json) {
    return EventsJson(
      day: DateTime.parse(json['day']),
      items: safeMap(json['items'], (item) => EventJson.fromJson(item)),
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
      id: json['id'],
    );
  }

  final int id;

  @override
  List<Object?> get props => [id];
}
