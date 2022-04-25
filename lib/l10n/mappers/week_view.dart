import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum WeekView {
  week,
  workWeek,
}

extension StringEx on String {
  WeekView get fromString => WeekView.values.firstWhere((e) => e.name == this);
}

extension WeekViewEx on WeekView {
  String l10n(AppLocalizations l10n) {
    switch (this) {
      case WeekView.week:
        return l10n.week;
      case WeekView.workWeek:
        return l10n.work_week;
    }
  }
}
