extension DateTimeEx on DateTime {
  // DateTime get startOfDay => DateTime(year, month, day);

  //DateTime get endOfDay => startOfDay
  // .add(const Duration(days: 1, milliseconds: -1));

  //DateTime get startOfWeek => startOfDay
  // .subtract(Duration(days: startOfDay.weekday - 1));

  //DateTime get startOfPreviousWeek => startOfWeek
  // .subtract(const Duration(days: 7));

  //DateTime get endOfWeek => endOfDay
  // .add(Duration(days: 7 - endOfDay.weekday));

  //DateTime get endOfNextWeek => endOfWeek.add(const Duration(days: 7));

  DateTime get truncate => DateTime(year, month, day);

  DateTime get lastDayOfMonth => DateTime(year, month + 1, 0);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}
