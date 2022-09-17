import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/ui/bordered.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';

class Calendars extends StatelessWidget {
  const Calendars({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableTile(
      context.l10n.calendars,
      initiallyExpanded: true,
      children: const [
        ExpandableTileItem('Urlaub', leading: _Dot(sonstiges)),
        ExpandableTileItem('Auslieferung', leading: _Dot(auslieferung)),
        ExpandableTileItem('Mietwagen', leading: _Dot(mietwagen)),
        ExpandableTileItem('Urlaub', leading: _Dot(urlaub)),
        ExpandableTileItem('Schulung', leading: _Dot(schulung)),
        ExpandableTileItem('Feiertage', leading: _Dot(feiertage)),
        ExpandableTileItem('Werkstatt', leading: _Dot(werkstatt)),
        ExpandableTileItem('Geburtstage', leading: _Dot(geburtstage)),
      ],
    );
  }
}

class _Dot extends Bordered {
  const _Dot(super.backgroundColor)
      : super(
          shape: BoxShape.circle,
          child: const SizedBox(width: 10, height: 10),
        );
}
