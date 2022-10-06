import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';

class Team extends StatelessWidget {
  const Team({super.key});

  @override
  Widget build(BuildContext context) => ExpandableTile(
        Text(context.l10n.team),
        children: const [
          ExpandableTileItem('Les Grossman'),
          ExpandableTileItem('Kirk Lazarus'),
          ExpandableTileItem('Alpa Chino'),
          ExpandableTileItem('Tugg Speedman'),
          ExpandableTileItem('Jeff Portnoy'),
          ExpandableTileItem('Rick Peck'),
        ],
      );
}
