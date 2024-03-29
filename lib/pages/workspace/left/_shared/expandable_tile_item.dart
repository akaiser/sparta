import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class ExpandableTileItem extends StatelessWidget {
  const ExpandableTileItem(
    this.title, {
    this.leading,
    super.key,
  });

  final String title;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final leading_ = leading;
    final itemText = _ExpandableTileItemText(title);
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 2, 6),
      child: leading_ != null
          ? Row(
              children: [
                leading_,
                const SizedBox(width: 6),
                Expanded(child: itemText),
              ],
            )
          : itemText,
    );
  }
}

class _ExpandableTileItemText extends StatelessWidget {
  const _ExpandableTileItemText(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: context.tt.labelMedium,
        overflow: TextOverflow.fade,
        softWrap: false,
      );
}
