import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  DateTime get midDay => DateTime(year, month, day, 12);

  DateTime get truncate => DateTime(year, month, day);

  DateTime get startOfWeek => add(Duration(days: 1 - weekday));

  DateTime get endOfWeek => add(Duration(days: 7 - weekday));

  DateTime get firstDayOfMonth => DateTime(year, month);

  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  DateTime get addWeek => add(const Duration(days: 7));

  DateTime get subtractWeek => subtract(const Duration(days: 7));

  DateTime get addMonth => copyWith(month: month + 1);

  DateTime get subtractMonth => copyWith(month: month - 1);

  DateTime get addYear => copyWith(year: year + 1);

  DateTime get subtractYear => copyWith(year: year - 1);

  bool isSameDay(DateTime? other) => isSameMonth(other) && day == other?.day;

  bool isSameMonth(DateTime? other) =>
      year == other?.year && month == other?.month;

  String get toCommonIsoDate => DateFormat('yyyy-MM-dd').format(this);

  DateTime copyWith({
    final int? year,
    final int? month,
    final int? day,
    final int? hour,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
    );
  }
}
