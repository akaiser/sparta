import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/ui/clickable_region.dart';

class HoverRegion extends StatefulWidget {
  const HoverRegion({
    required this.builder,
    this.onHoverCursor,
    this.child,
    super.key,
  });

  final Widget Function(
    BuildContext context,
    bool isHovering,
    Widget? child,
  ) builder;

  final SystemMouseCursor? onHoverCursor;
  final Widget? child;

  @override
  HoverRegionState createState() => HoverRegionState();
}

class HoverRegionState extends State<HoverRegion> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return ClickableRegion(
      cursor: widget.onHoverCursor,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.builder(context, _isHovering, widget.child),
    );
  }
}
