import 'package:flutter/widgets.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

const _dividerWidth = 8.0;
const _separatorWidth = 1.0;

class SimpleSplit extends StatelessWidget {
  const SimpleSplit({
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
        return _SplitView(
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

class _SplitView extends StatefulWidget {
  const _SplitView({
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

  double _leftWidthCalculated(double leftWidth) {
    return widget.maxWidth - leftWidth < 0 ? widget.maxWidth : leftWidth;
  }

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
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          maintainState: true,
          visible: widget.leftViewVisible,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: _separatorWidth),
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
                child: _Separator(onDxUpdate: _updateLeftWidth),
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
                        offset: const Offset(-5, 0),
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

class _Separator extends StatelessWidget {
  const _Separator({
    required this.onDxUpdate,
    Key? key,
  }) : super(key: key);

  final void Function(double dx) onDxUpdate;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (details) => onDxUpdate(details.delta.dx),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(width: _dividerWidth),
            SizedBox(
              width: _separatorWidth,
              child: ColoredBox(color: context.td.dividerColor),
            ),
          ],
        ),
      ),
    );
  }
}
