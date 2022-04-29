import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/workspace/left/_shared/expandable_tile_item.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile(
    this.title, {
    required this.children,
    this.initiallyExpanded = false,
    Key? key,
  }) : super(key: key);

  final String title;
  final bool initiallyExpanded;
  final List<ExpandableTileItem> children;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.td.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(left: 16, right: 10),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedTextColor: context.td.disabledColor,
        collapsedIconColor: context.td.disabledColor,
        textColor: context.td.hintColor,
        iconColor: context.td.hintColor,
        initiallyExpanded: initiallyExpanded,
        title: Text(
          title,
          style: TextStyle(
            fontSize: context.tt.subtitle2.fontSize,
            fontWeight: context.tt.subtitle2.fontWeight,
          ),
        ),
        children: children,
      ),
    );
  }
}
