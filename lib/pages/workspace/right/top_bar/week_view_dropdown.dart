import 'package:flutter/material.dart';
import 'package:sparta/l10n/mappers/week_view.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/states/settings_state.dart';

class WeekViewDropdown extends StatelessWidget {
  const WeekViewDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ValueConnector<WeekView>(
        converter: (state) => state.settingsState.weekView,
        builder: (context, selectedWeekView, _) {
          return DropdownButton<WeekView>(
            isDense: true,
            style: context.tt.bodyMedium,
            value: selectedWeekView,
            focusColor: Colors.transparent,
            onChanged: (changedWeekView) {
              if (selectedWeekView != changedWeekView!) {
                context.store.dispatch(SetWeekViewAction(changedWeekView));
              }
            },
            items: WeekView.values
                .map(
                  (weekView) => DropdownMenuItem<WeekView>(
                    value: weekView,
                    child: Text(weekView.l10n(context.l10n)),
                  ),
                )
                .unmodifiable,
          );
        },
      ),
    );
  }
}
