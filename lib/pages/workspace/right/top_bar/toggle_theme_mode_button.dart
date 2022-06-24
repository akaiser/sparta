import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/states/settings_state.dart';

class ToggleThemeModeButton extends StatelessWidget {
  const ToggleThemeModeButton({super.key});

  static const _action = ToggleThemeAction();

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isLightTheme,
      builder: (context, isLightTheme, _) => HoverIconButton(
        isLightTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        onPressed: () => context.store.dispatch(_action),
      ),
    );
  }
}
