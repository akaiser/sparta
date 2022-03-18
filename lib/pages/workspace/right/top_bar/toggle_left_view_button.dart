import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/base_icon_button.dart';
import 'package:sparta/states/settings_state.dart';

class ToggleLeftViewButton extends StatelessWidget {
  const ToggleLeftViewButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: (state) => state.settingsState.isLeftViewVisible,
      builder: (context, isLeftViewVisible) => BaseIconButton(
        isLeftViewVisible ? Icons.menu_open : Icons.menu,
        onPressed: () => context.dispatch(
          const ToggleLeftViewVisibilityAction(),
        ),
      ),
    );
  }
}
