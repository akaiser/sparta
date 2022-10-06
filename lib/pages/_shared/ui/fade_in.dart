import 'package:flutter/widgets.dart';

class FadeIn extends StatefulWidget {
  const FadeIn({
    required this.child,
    this.millis = 200,
    super.key,
  });

  final int millis;
  final Widget child;

  @override
  State<FadeIn> createState() => _FadeInState();
}

class _FadeInState extends State<FadeIn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.millis),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    _controller.forward();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
        opacity: _controller.drive(CurveTween(curve: Curves.easeIn)),
        child: widget.child,
      );
}
