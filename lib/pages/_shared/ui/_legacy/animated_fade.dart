import 'package:flutter/widgets.dart';

class AnimatedFade extends StatelessWidget {
  const AnimatedFade(
    this.showFirstNotifier, {
    required this.firstChild,
    required this.secondChild,
    super.key,
  });

  final ValueNotifier<bool> showFirstNotifier;
  final Widget firstChild;
  final Widget secondChild;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: showFirstNotifier,
        builder: (context, showFirst, _) => AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          firstChild: firstChild,
          secondChild: secondChild,
          crossFadeState:
              showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          layoutBuilder: (topChild, _, bottomChild, __) => Stack(
            alignment: Alignment.center,
            children: [topChild, bottomChild],
          ),
        ),
      );
}
