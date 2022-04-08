import 'dart:async' show runZonedGuarded;
import 'dart:developer' show log;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/_prefs.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/workspace_page.dart';

final _store = Store<AppState>(
  appStateReducer,
  initialState: const AppState(),
  middleware: [
    EpicMiddleware(appEpics()),
    LoggingMiddleware.printer(),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Prefs.init();

  runZonedGuarded<void>(
    () => runApp(StoreProvider(store: _store, child: const _App())),
    (error, stack) => log('Some Explosion...', error: error, stackTrace: stack),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isLightTheme,
      builder: (context, isLightTheme) => MaterialApp(
        themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.l10n.app_name,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const WorkspacePage(),
        // TODO
        //initialRoute: LoginPage.route,
        //routes: {WorkspacePage.route: (_) => const WorkspacePage()},
      ),
    );
  }
}
