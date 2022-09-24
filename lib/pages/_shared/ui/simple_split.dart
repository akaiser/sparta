import 'package:flutter/material.dart';

const _dividerWidth = 8.0;
const _dividerBorderWidth = 1.0;

class SimpleSplit extends StatelessWidget {
  const SimpleSplit({
    required this.left,
    required this.right,
    required this.leftViewVisible,
    required this.dividerBorderColor,
    this.initLeftWidth,
    super.key,
  });

  final Widget left;
  final Widget right;
  final bool leftViewVisible;
  final Color dividerBorderColor;
  final double? initLeftWidth;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constrains) => _SplitView(
          left: left,
          right: right,
          maxWidth: constrains.maxWidth,
          leftViewVisible: leftViewVisible,
          dividerBorderColor: dividerBorderColor,
          initLeftWidth: initLeftWidth,
        ),
      );
}

class _SplitView extends StatefulWidget {
  const _SplitView({
    required this.left,
    required this.right,
    required this.maxWidth,
    required this.leftViewVisible,
    required this.dividerBorderColor,
    required this.initLeftWidth,
  });

  final Widget left;
  final Widget right;
  final double maxWidth;
  final bool leftViewVisible;
  final Color dividerBorderColor;
  final double? initLeftWidth;

  @override
  _SplitViewState createState() => _SplitViewState();
}

class _SplitViewState extends State<_SplitView> {
  late final ValueNotifier<double> _leftWidthNotifier;

  @override
  void initState() {
    super.initState();
    final initLeftWidth = widget.initLeftWidth ?? (widget.maxWidth / 3.5);
    _leftWidthNotifier = ValueNotifier(initLeftWidth);
  }

  @override
  void dispose() {
    _leftWidthNotifier.dispose();
    super.dispose();
  }

  double _leftWidthCalculated(double leftWidth) =>
      widget.maxWidth - leftWidth < 0 ? widget.maxWidth : leftWidth;

  void _updateLeftWidth(double dx) {
    final leftWidthCurrent = _leftWidthNotifier.value;
    var leftWidthTemp = leftWidthCurrent + dx;
    if (leftWidthTemp < 0) {
      leftWidthTemp = 0;
    } else if (leftWidthTemp > widget.maxWidth) {
      leftWidthTemp = widget.maxWidth;
    }
    if (leftWidthCurrent != leftWidthTemp) {
      _leftWidthNotifier.value = leftWidthTemp;
    }
  }

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Visibility(
            maintainState: true,
            visible: widget.leftViewVisible,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: _dividerBorderWidth),
                  child: ValueListenableBuilder<double>(
                    valueListenable: _leftWidthNotifier,
                    builder: (context, leftWidth, child) => SizedBox(
                      width: _leftWidthCalculated(leftWidth),
                      child: child,
                    ),
                    child: widget.left,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  bottom: 0,
                  child: _Divider(
                    onDxUpdate: _updateLeftWidth,
                    dividerBorderColor: widget.dividerBorderColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    offset: Offset(-5, 0),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: widget.right,
            ),
          ),
        ],
      );
}

class _Divider extends StatelessWidget {
  const _Divider({
    required this.onDxUpdate,
    required this.dividerBorderColor,
  });

  final ValueSetter<double> onDxUpdate;
  final Color dividerBorderColor;

  @override
  Widget build(BuildContext context) => MouseRegion(
        cursor: SystemMouseCursors.resizeColumn,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onPanUpdate: (details) => onDxUpdate(details.delta.dx),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(width: _dividerWidth),
              SizedBox(
                width: _dividerBorderWidth,
                child: ColoredBox(color: dividerBorderColor),
              ),
            ],
          ),
        ),
      );
}
