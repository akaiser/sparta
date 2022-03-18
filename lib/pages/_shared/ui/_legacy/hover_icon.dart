import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/ui/_legacy/hover_region.dart';

const _iconPadding = EdgeInsets.all(2);

class HoverIcon extends StatelessWidget {
  const HoverIcon(
    this.iconData, {
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return onTap == null
        ? Padding(
            padding: _iconPadding,
            child: Icon(iconData),
          )
        : GestureDetector(
            onTap: onTap,
            child: HoverRegion(
              builder: (context, isHovering, child) {
                return AnimatedContainer(
                  padding: _iconPadding,
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isHovering ? context.td.hoverColor : null,
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: child!,
                );
              },
              child: Icon(iconData),
            ),
          );
  }
}
