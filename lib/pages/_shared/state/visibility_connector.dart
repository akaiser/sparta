import 'package:flutter/widgets.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class VisibilityConnector extends StatelessWidget {
  const VisibilityConnector({
    required this.visible,
    required this.builder,
    Key? key,
  }) : super(key: key);

  final bool Function(AppState state) visible;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: visible,
      builder: (context, shouldShow) {
        return shouldShow ? builder(context) : const SizedBox();
      },
    );
  }
}

class VisibilityConnector2 extends StatelessWidget {
  const VisibilityConnector2({
    required this.visible,
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  final bool Function(AppState state) visible;
  final TransitionBuilder builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueConnector2<bool>(
      converter: visible,
      builder: (context, shouldShow, child) {
        return shouldShow ? builder(context, child) : const SizedBox();
      },
      child: child,
    );
  }
}
