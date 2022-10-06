import 'package:equatable/equatable.dart';
import 'package:sparta/pages/_shared/models/calendar_model.dart';
import 'package:sparta/pages/_shared/models/category_model.dart';

class DayEventModel extends Equatable {
  const DayEventModel({
    required this.id,
    required this.calendar,
    required this.categories,
  });

  final String id;
  final CalendarModel calendar;
  final Iterable<CategoryModel> categories;

  @override
  List<Object?> get props => [id, calendar, categories];
}
