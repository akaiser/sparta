import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class BaseIconButton extends StatelessWidget {
  const BaseIconButton(
    this.iconData, {
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.all(2),
      constraints: const BoxConstraints(),
      hoverColor: context.td.splashColor,
      splashRadius: 15,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}
