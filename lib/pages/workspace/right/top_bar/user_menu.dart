import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: '',
      itemBuilder: (context) {
        final textStyle = context.tt.bodyMedium;
        return [
          PopupMenuItem(child: Text('Admin', style: textStyle)),
          PopupMenuItem(child: Text('Logout', style: textStyle)),
        ];
      },
      child: const SizedBox(
        width: 30,
        height: 30,
        child: ColoredBox(
          color: Colors.lightBlue,
          child: Center(child: Text('AK')),
        ),
      ),
    );
  }
}
