import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class SimpleSplitView extends StatelessWidget {
  const SimpleSplitView({
    required this.left,
    required this.right,
    required this.leftViewVisible,
    this.initLeftWidth,
    Key? key,
  }) : super(key: key);

  final Widget left;
  final Widget right;
  final bool leftViewVisible;
  final double? initLeftWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return _SimpleSplitView(
          left: left,
          right: right,
          maxWidth: constrains.maxWidth,
          leftViewVisible: leftViewVisible,
          initLeftWidth: initLeftWidth,
        );
      },
    );
  }
}

class _SimpleSplitView extends StatefulWidget {
  const _SimpleSplitView({
    required this.left,
    required this.right,
    required this.maxWidth,
    required this.leftViewVisible,
    required this.initLeftWidth,
    Key? key,
  }) : super(key: key);

  final Widget left;
  final Widget right;
  final double maxWidth;
  final bool leftViewVisible;
  final double? initLeftWidth;

  @override
  _SimpleSplitViewState createState() => _SimpleSplitViewState();
}

class _SimpleSplitViewState extends State<_SimpleSplitView> {
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

  double _leftWidthCalculated(double leftWidth) {
    return widget.maxWidth - leftWidth < 0 ? widget.maxWidth : leftWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          maintainState: true,
          visible: widget.leftViewVisible,
          child: Stack(
            children: [
              ValueListenableBuilder<double>(
                valueListenable: _leftWidthNotifier,
                builder: (context, leftWidth, child) {
                  return SizedBox(
                    width: _leftWidthCalculated(leftWidth),
                    child: child,
                  );
                },
                child: widget.left,
              ),
              Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      final leftWidthCurrent = _leftWidthNotifier.value;
                      var leftWidthTemp = leftWidthCurrent + details.delta.dx;
                      if (leftWidthTemp < 0) {
                        leftWidthTemp = 0;
                      } else if (leftWidthTemp > widget.maxWidth) {
                        leftWidthTemp = widget.maxWidth;
                      }
                      if (leftWidthCurrent != leftWidthTemp) {
                        _leftWidthNotifier.value = leftWidthTemp;
                      }
                    },
                    child: const ColoredBox(
                      color: Colors.transparent,
                      child: SizedBox(width: 8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: widget.leftViewVisible
                  ? [
                      BoxShadow(
                        blurRadius: 10,
                        offset: const Offset(-4, 0),
                        color: context.td.primaryColorDark,
                      ),
                    ]
                  : null,
            ),
            child: widget.right,
          ),
        ),
      ],
    );
  }
}
