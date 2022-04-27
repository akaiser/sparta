import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';

class ValueConnector<T> extends StatelessWidget {
  const ValueConnector({
    required this.converter,
    required this.builder,
    this.onInit,
    this.ignoreChange,
    Key? key,
  }) : super(key: key);

  final T Function(AppState state) converter;
  final ViewModelBuilder<T> builder;
  final void Function(AppState state)? onInit;
  final bool Function(AppState state)? ignoreChange;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, T>(
      distinct: true,
      onInit: onInit != null ? (store) => onInit!(store.state) : null,
      ignoreChange: ignoreChange,
      converter: (store) => converter(store.state),
      builder: builder,
    );
  }
}

class ValueConnector2<T> extends StatelessWidget {
  const ValueConnector2({
    required this.converter,
    required this.builder,
    this.onInit,
    this.child,
    Key? key,
  }) : super(key: key);

  final T Function(AppState state) converter;
  final ValueWidgetBuilder<T> builder;
  final void Function(AppState state)? onInit;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, T>(
      distinct: true,
      onInit: onInit != null ? (store) => onInit!(store.state) : null,
      converter: (store) => converter(store.state),
      builder: (context, vm) => builder.call(context, vm, child),
    );
  }
}
