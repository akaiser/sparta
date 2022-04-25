import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

extension WeekDayEx on WeekDay {
  String l10n(AppLocalizations l10n) {
    switch (this) {
      case WeekDay.monday:
        return l10n.monday;
      case WeekDay.tuesday:
        return l10n.tuesday;
      case WeekDay.wednesday:
        return l10n.wednesday;
      case WeekDay.thursday:
        return l10n.thursday;
      case WeekDay.friday:
        return l10n.friday;
      case WeekDay.saturday:
        return l10n.saturday;
      case WeekDay.sunday:
        return l10n.sunday;
    }
  }

  String l10nShort(AppLocalizations l10n) {
    switch (this) {
      case WeekDay.monday:
        return l10n.monday_short;
      case WeekDay.tuesday:
        return l10n.tuesday_short;
      case WeekDay.wednesday:
        return l10n.wednesday_short;
      case WeekDay.thursday:
        return l10n.thursday_short;
      case WeekDay.friday:
        return l10n.friday_short;
      case WeekDay.saturday:
        return l10n.saturday_short;
      case WeekDay.sunday:
        return l10n.sunday_short;
    }
  }
}
