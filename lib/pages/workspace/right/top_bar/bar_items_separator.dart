import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class BarItemsSeparator extends StatelessWidget {
  const BarItemsSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ColoredBox(
        color: context.td.dividerColor,
        child: const SizedBox(
          width: sectionsDividerThickness,
          height: 28,
        ),
      ),
    );
  }
}
