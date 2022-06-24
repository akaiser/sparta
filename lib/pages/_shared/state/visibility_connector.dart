import 'package:flutter/widgets.dart';
import 'package:sparta/_states.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class VisibilityConnector extends StatelessWidget {
  const VisibilityConnector({
    required this.visible,
    required this.builder,
    super.key,
  });

  final bool Function(AppState state) visible;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ValueConnector<bool>(
      converter: visible,
      builder: (context, shouldShow, _) {
        return shouldShow ? builder(context) : const SizedBox();
      },
    );
  }
}
