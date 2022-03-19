import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';

class Calendars extends StatelessWidget {
  const Calendars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableTile(
      context.l10n.calendars,
      children: const [
        ExpandableTileItem('Urlaub'),
        ExpandableTileItem('Mietwagen'),
        ExpandableTileItem('Werkstatt'),
        ExpandableTileItem('Geburtstage'),
        ExpandableTileItem('Auslieferung'),
      ],
    );
  }
}
