import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/models/event_json.dart';

class EventModel extends Equatable {
  const EventModel({required this.id});

  factory EventModel.fromJson(EventJson json) => EventModel(id: json.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
