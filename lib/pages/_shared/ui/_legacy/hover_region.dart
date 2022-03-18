import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/ui/_legacy/clickable_region.dart';

class HoverRegion extends StatefulWidget {
  const HoverRegion({
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    bool isHovering,
    Widget? child,
  ) builder;

  final Widget? child;

  @override
  _HoverRegionState createState() => _HoverRegionState();
}

class _HoverRegionState extends State<HoverRegion> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return ClickableRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: widget.builder(context, _isHovering, widget.child),
    );
  }
}
