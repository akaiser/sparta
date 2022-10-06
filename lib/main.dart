import 'dart:async' show runZonedGuarded;
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:sparta/_epics.dart';
import 'package:sparta/_init.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_startup_page.dart';

final _store = Store<AppState>(
  appStateReducer,
  initialState: const AppState(),
  middleware: [EpicMiddleware(appEpics())],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Init.init();

  runZonedGuarded<void>(
    () => runApp(const App()),
    (error, stack) => log(
      'Some Explosion...',
      error: error,
      stackTrace: stack,
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => StoreProvider(
        store: _store,
        child: ValueConnector<bool>(
          converter: (state) => state.settingsState.isLightTheme,
          builder: (context, isLightTheme, _) => MaterialApp(
            themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => context.l10n.app_name,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            home: const StartupPage(),
            // TODO(albert): finish StartupPage.route
            //initialRoute: LoginPage.route,
            //routes: {WorkspacePage.route: (_) => const WorkspacePage()},
          ),
        ),
      );
}
