import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/ui/bordered.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge(
    this.backgroundColor, {
    this.child,
    super.key,
  });

  final Color backgroundColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Bordered(
        backgroundColor,
        child: SizedBox(
          width: 9,
          height: 14,
          child: child != null ? Center(child: child) : child,
        ),
      );
}
