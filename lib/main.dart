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
import 'package:sparta/pages/workspace_page.dart';

final _store = Store<AppState>(
  appStateReducer,
  initialState: const AppState(),
  middleware: [
    EpicMiddleware(appEpics()),
    //if (kDebugMode) LoggingMiddleware.printer(),
  ],
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Init.init();

  runZonedGuarded<void>(
    () => runApp(StoreProvider(store: _store, child: const _App())),
    (error, stack) => log('Some Explosion...', error: error, stackTrace: stack),
  );
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isLightTheme,
      builder: (context, isLightTheme, _) => MaterialApp(
        themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => context.l10n.app_name,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const WorkspacePage(),
        // TODO(albert): finish
        //initialRoute: LoginPage.route,
        //routes: {WorkspacePage.route: (_) => const WorkspacePage()},
      ),
    );
  }
}
