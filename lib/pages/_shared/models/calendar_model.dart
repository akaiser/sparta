import 'dart:ui' show Color;

import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/extensions/color.dart';
import 'package:sparta/pages/_shared/models/calendars_json.dart';

class CalendarModel extends Equatable {
  const CalendarModel._({
    required this.id,
    required this.title,
    required this.color,
  });

  factory CalendarModel.fromJson(CalendarJson json) => CalendarModel._(
        id: json.id,
        title: json.title,
        color: json.color.fromHex,
      );

  final String id;
  final String title;
  final Color color;

  @override
  List<Object?> get props => [id, title, color];
}
