import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:sparta/_states.dart';

class ValueConnector<T> extends StatelessWidget {
  const ValueConnector({
    required this.converter,
    required this.builder,
    this.onInit,
    Key? key,
  }) : super(key: key);

  final T Function(AppState state) converter;
  final ViewModelBuilder<T> builder;
  final void Function(AppState state, dynamic dispatch)? onInit;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, T>(
      distinct: true,
      onInit: onInit != null
          ? (store) => onInit!(store.state, store.dispatch)
          : null,
      converter: (store) => converter(store.state),
      builder: builder,
    );
  }
}
