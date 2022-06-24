import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ClickableRegion extends MouseRegion {
  const ClickableRegion({
    required Widget super.child,
    SystemMouseCursor? cursor,
    super.onEnter,
    super.onExit,
    super.key,
  }) : super(
          cursor: cursor ?? SystemMouseCursors.click,
        );
}
