import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ListenableBuilder<T, V> extends StatelessWidget {
  const ListenableBuilder({
    required this.listenable,
    required this.converter,
    required this.builder,
    this.child,
    Key? key,
  }) : super(key: key);

  final ValueListenable<T> listenable;
  final V Function(T value) converter;
  final ValueWidgetBuilder<V> builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<T>(
      valueListenable: listenable,
      builder: (context, value, child) => builder(
        context,
        converter(value),
        child,
      ),
      child: child,
    );
  }
}
