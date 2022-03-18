import 'package:flutter/widgets.dart';

class SimpleSplitView extends StatelessWidget {
  const SimpleSplitView({
    required this.left,
    required this.right,
    this.dividerWidth = 4,
    this.dividerColor = const Color.fromRGBO(78, 74, 82, 1),
    this.leftViewVisible = true,
    Key? key,
  }) : super(key: key);

  final Widget left;
  final Widget right;

  final double dividerWidth;
  final Color dividerColor;

  final bool leftViewVisible;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) => _SimpleSplitView(
        left: left,
        right: right,
        dividerWidth: dividerWidth,
        dividerColor: dividerColor,
        leftViewVisible: leftViewVisible,
        leftWidthMax: constrains.maxWidth - dividerWidth,
      ),
    );
  }
}

class _SimpleSplitView extends StatefulWidget {
  const _SimpleSplitView({
    required this.left,
    required this.right,
    required this.dividerWidth,
    required this.dividerColor,
    required this.leftViewVisible,
    required this.leftWidthMax,
    Key? key,
  })  : leftWidthOnInit = leftWidthMax / 3.5,
        super(key: key);

  final Widget left;
  final Widget right;
  final double dividerWidth;
  final Color dividerColor;
  final bool leftViewVisible;
  final double leftWidthMax;

  final double leftWidthOnInit;

  @override
  _SimpleSplitViewState createState() => _SimpleSplitViewState();
}

class _SimpleSplitViewState extends State<_SimpleSplitView> {
  late ValueNotifier<double> _leftWidthNotifier;

  @override
  void initState() {
    super.initState();
    _leftWidthNotifier = ValueNotifier(widget.leftWidthOnInit);
  }

  @override
  void dispose() {
    _leftWidthNotifier.dispose();
    super.dispose();
  }

  double _leftWidthCalculated(double leftWidth) {
    return widget.leftWidthMax - leftWidth < 0
        ? widget.leftWidthMax
        : leftWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          maintainState: true,
          visible: widget.leftViewVisible,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ValueListenableBuilder<double>(
                valueListenable: _leftWidthNotifier,
                builder: (context, leftWidth, child) {
                  final leftWidthCalculated = _leftWidthCalculated(leftWidth);
                  return SizedBox(
                    width: leftWidthCalculated,
                    child: leftWidthCalculated > 0 ? child : null,
                  );
                },
                child: widget.left,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.resizeLeftRight,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    final leftWidthCurrent = _leftWidthNotifier.value;
                    var leftWidthTemp = leftWidthCurrent + details.delta.dx;
                    if (leftWidthTemp < 0) {
                      leftWidthTemp = 0;
                    } else if (leftWidthTemp > widget.leftWidthMax) {
                      leftWidthTemp = widget.leftWidthMax;
                    }
                    if (leftWidthCurrent != leftWidthTemp) {
                      _leftWidthNotifier.value = leftWidthTemp;
                    }
                  },
                  child: ColoredBox(
                    color: widget.dividerColor,
                    child: SizedBox(width: widget.dividerWidth),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: widget.right),
      ],
    );
  }
}
