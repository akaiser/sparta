import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  DateTime get midDay => DateTime(year, month, day, 12);

  DateTime get truncate => DateTime(year, month, day);

  DateTime get startOfWeek => add(Duration(days: 1 - weekday));

  DateTime get endOfWeek => add(Duration(days: 7 - weekday));

  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  DateTime get addWeek => add(const Duration(days: 7));

  DateTime get subtractWeek => subtract(const Duration(days: 7));

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  String get toCommonIsoDate => DateFormat('yyyy-MM-dd').format(this);
}
