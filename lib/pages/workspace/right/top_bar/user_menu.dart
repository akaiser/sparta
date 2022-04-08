import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: PopupMenuButton(
        tooltip: '',
        itemBuilder: (context) {
          final textStyle = context.tt.bodyMedium;
          return [
            PopupMenuItem(child: Text('Admin', style: textStyle)),
            PopupMenuItem(child: Text('Logout', style: textStyle)),
          ];
        },
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            //shape: BoxShape.circle,
            color: accentColor,
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: const Center(child: Text('AK')),
        ),
      ),
    );
  }
}
