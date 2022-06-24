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
      child: PopupMenuButton<String>(
        tooltip: '',
        itemBuilder: (context) {
          final textStyle = context.tt.bodyMedium;
          return [
            PopupMenuItem(child: Text('Admin', style: textStyle)),
            PopupMenuItem(child: Text('Logout', style: textStyle)),
          ];
        },
        child: const SizedBox(
          width: 28,
          height: 28,
          child: DecoratedBox(
            decoration: BoxDecoration(
              //shape: BoxShape.circle,
              color: lightBlue,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: Center(child: Text('AK')),
          ),
        ),
      ),
    );
  }
}
