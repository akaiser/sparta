import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class Bordered extends StatelessWidget {
  const Bordered(
    this.backgroundColor, {
    this.shape = BoxShape.rectangle,
    this.borderWidth = 1.0,
    required this.child,
    super.key,
  });

  final Color backgroundColor;
  final BoxShape shape;
  final double borderWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: shape,
          border: Border.fromBorderSide(
            BorderSide(
              width: borderWidth,
              color: context.td.primaryColorDark,
            ),
          ),
        ),
        child: child,
      );
}
