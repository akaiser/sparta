import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/workspace/left/date_picker.dart';

class LeftView extends StatelessWidget {
  const LeftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('BUILD_LeftView');
    return Column(
      children: const [
        DatePicker(),
        SizedBox(height: 30),
        _ExpansionTile('Kalender'),
        _ExpansionTile('Team'),
        _ExpansionTile('Globale Notizen'),
        // Calendars(),
        // Chat(),
      ],
    );
  }
}

class _ExpansionTile extends StatelessWidget {
  const _ExpansionTile(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.only(left: 16, right: 10),
      expandedAlignment: Alignment.centerLeft,
      collapsedTextColor: context.td.disabledColor,
      collapsedIconColor: context.td.disabledColor,
      textColor: context.td.hintColor,
      iconColor: context.td.hintColor,
      title: Text(
        title,
        style: TextStyle(fontSize: context.tt.bodyLarge.fontSize),
      ),
      children: const [
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('This is tile number 1'),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text('This is tile number 2'),
        )
      ],
    );
  }
}
