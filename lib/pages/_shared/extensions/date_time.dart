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

  DateTime get addMonth => _copyWith(month: month + 1);

  DateTime get subtractMonth => _copyWith(month: month - 1);

  DateTime get addYear => _copyWith(year: year + 1);

  DateTime get subtractYear => _copyWith(year: year - 1);

  bool isSameDay(DateTime? other) => isSameMonth(other) && day == other?.day;

  bool isSameMonth(DateTime? other) =>
      year == other?.year && month == other?.month;

  String get toCommonIsoDate => DateFormat('yyyy-MM-dd').format(this);

  int get weekNumber => _weekNumber(this);

  DateTime _copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
  }) =>
      DateTime(
        year ?? this.year,
        month ?? this.month,
        day ?? this.day,
        hour ?? this.hour,
      );
}

int _weekNumber(DateTime date) {
  final dayOfYear = int.parse(DateFormat('D').format(date));
  final weekOfYear = ((dayOfYear - date.weekday + 10) / 7).floor();
  return weekOfYear < 1
      ? _numOfWeeks(date.year - 1)
      : weekOfYear > _numOfWeeks(date.year)
          ? 1
          : weekOfYear;
}

int _numOfWeeks(int year) {
  final dec28 = DateTime(year, 12, 28);
  final dayOfDec28 = int.parse(DateFormat('D').format(dec28));
  return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
}
