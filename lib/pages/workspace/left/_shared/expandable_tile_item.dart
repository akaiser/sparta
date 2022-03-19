import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class ExpandableTileItem extends StatelessWidget {
  const ExpandableTileItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: _ExpandableTileItemText(title),
    );
  }
}

class _ExpandableTileItemText extends StatelessWidget {
  const _ExpandableTileItemText(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.tt.labelMedium,
    );
  }
}
