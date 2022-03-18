import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/base_icon_button.dart';
import 'package:sparta/states/settings_state.dart';

class ToggleThemeModeButton extends StatelessWidget {
  const ToggleThemeModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isLightTheme,
      builder: (context, isLightTheme) => BaseIconButton(
        isLightTheme ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        onPressed: () => context.dispatch(const ToggleThemeAction()),
      ),
    );
  }
}
