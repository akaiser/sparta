import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/ui/hover_region.dart';

const _iconPadding = EdgeInsets.all(2);

class HoverIconButton extends StatelessWidget {
  const HoverIconButton(
    this.iconData, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return onPressed == null
        ? Padding(
            padding: _iconPadding,
            child: Icon(
              iconData,
              color: context.td.disabledColor,
            ),
          )
        : GestureDetector(
            onTap: onPressed,
            child: HoverRegion(
              builder: (context, isHovering, child) {
                return AnimatedContainer(
                  padding: _iconPadding,
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isHovering ? context.td.focusColor : null,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: child!,
                );
              },
              child: Icon(iconData),
            ),
          );
  }
}
