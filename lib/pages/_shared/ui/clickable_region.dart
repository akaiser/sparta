import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ClickableRegion extends MouseRegion {
  const ClickableRegion({
    required Widget child,
    SystemMouseCursor? cursor,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    Key? key,
  }) : super(
          key: key,
          cursor: cursor ?? SystemMouseCursors.click,
          onEnter: onEnter,
          onExit: onExit,
          child: child,
        );
}
