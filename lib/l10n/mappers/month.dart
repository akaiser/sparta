import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum Month {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december,
}

extension IntEx on int {
  Month get toMonth => Month.values.elementAt(this - 1);
}

extension MonthEx on Month {
  String l10n(AppLocalizations l10n) {
    switch (this) {
      case Month.january:
        return l10n.january;
      case Month.february:
        return l10n.february;
      case Month.march:
        return l10n.march;
      case Month.april:
        return l10n.april;
      case Month.may:
        return l10n.may;
      case Month.june:
        return l10n.june;
      case Month.july:
        return l10n.july;
      case Month.august:
        return l10n.august;
      case Month.september:
        return l10n.september;
      case Month.october:
        return l10n.october;
      case Month.november:
        return l10n.november;
      case Month.december:
        return l10n.december;
    }
  }

  String l10nShort(AppLocalizations l10n) {
    switch (this) {
      case Month.january:
        return l10n.january_short;
      case Month.february:
        return l10n.february_short;
      case Month.march:
        return l10n.march_short;
      case Month.april:
        return l10n.april_short;
      case Month.may:
        return l10n.may_short;
      case Month.june:
        return l10n.june_short;
      case Month.july:
        return l10n.july_short;
      case Month.august:
        return l10n.august_short;
      case Month.september:
        return l10n.september_short;
      case Month.october:
        return l10n.october_short;
      case Month.november:
        return l10n.november_short;
      case Month.december:
        return l10n.december_short;
    }
  }
}
