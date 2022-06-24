import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    return ExpandableTile(
      context.l10n.notes,
      children: const [
        ExpandableTileItem('TBD'),
        ExpandableTileItem('TBD'),
      ],
    );
  }
}
