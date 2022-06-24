import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class ExpandableTileItem extends StatelessWidget {
  const ExpandableTileItem(
    this.title, {
    this.leading,
    Key? key,
  }) : super(key: key);

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
                Flexible(child: itemText),
              ],
            )
          : itemText,
    );
  }
}

class _ExpandableTileItemText extends StatelessWidget {
  const _ExpandableTileItemText(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.tt.labelMedium,
      overflow: TextOverflow.ellipsis,
    );
  }
}
