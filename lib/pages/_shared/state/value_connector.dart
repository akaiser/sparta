import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';

class ValueConnector<T> extends StatelessWidget {
  const ValueConnector({
    required this.converter,
    required this.builder,
    this.onInit,
    this.ignoreChange,
    this.child,
    this.onWillChange, // TODO(albert): verify usage
    super.key,
  });

  final T Function(AppState state) converter;
  final ValueWidgetBuilder<T> builder;
  final ValueSetter<AppState>? onInit;
  final bool Function(AppState state)? ignoreChange;
  final Widget? child;

  final void Function(T? prev, T vm)? onWillChange;

  @override
  Widget build(BuildContext context) {
    final onInit_ = onInit;
    return StoreConnector<AppState, T>(
      distinct: true,
      onWillChange: onWillChange,
      onInit: onInit_ != null ? (store) => onInit_(store.state) : null,
      ignoreChange: ignoreChange,
      converter: (store) => converter(store.state),
      builder: (context, vm) => builder.call(context, vm, child),
    );
  }
}
