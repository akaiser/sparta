import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 14,
        width: 14,
        child: CircularProgressIndicator(strokeWidth: 2.4),
      );
}
