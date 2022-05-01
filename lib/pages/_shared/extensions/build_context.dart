import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/_themes.dart';

extension BuildContextEx on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Function(dynamic action) get dispatch =>
      StoreProvider.of<AppState>(this, listen: false).dispatch;

  Locale get l => Localizations.localeOf(this);

  String get lc => l.languageCode;

  ThemeData get td => Theme.of(this);

  AppTextTheme get tt => AppTextTheme(td.textTheme);
}
