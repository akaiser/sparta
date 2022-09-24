import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

const _borderWidth = 0.6;

class Bordered extends StatelessWidget {
  const Bordered(
    this.backgroundColor, {
    this.shape = BoxShape.rectangle,
    required this.child,
    super.key,
  });

  final Color backgroundColor;
  final BoxShape shape;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: shape,
          border: Border.all(
            width: _borderWidth,
            color: context.td.primaryColorDark,
          ),
        ),
        child: child,
      );
}
