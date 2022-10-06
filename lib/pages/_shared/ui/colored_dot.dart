import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/ui/bordered.dart';

class ColoredDot extends Bordered {
  ColoredDot(
    super.backgroundColor, {
    double size = 10,
    Widget? child,
    super.key,
  }) : super(
          shape: BoxShape.circle,
          child: SizedBox(
            width: size,
            height: size,
            child: child != null ? Center(child: child) : child,
          ),
        );
}
