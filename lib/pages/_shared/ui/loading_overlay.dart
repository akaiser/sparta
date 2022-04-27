import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/ui/fade_in.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FadeIn(
      child: ColoredBox(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
