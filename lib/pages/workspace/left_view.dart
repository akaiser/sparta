import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/workspace/left/calendars/calendars.dart';
import 'package:sparta/pages/workspace/left/date_controls.dart';
import 'package:sparta/pages/workspace/left/date_picker.dart';
import 'package:sparta/pages/workspace/left/notes/notes.dart';
import 'package:sparta/pages/workspace/left/team/team.dart';

class LeftView extends StatelessWidget {
  const LeftView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: DateControls(),
        ),
        verticalDivider,
        const DatePicker(),
        verticalDivider,
        Expanded(
          child: ListView(
            children: const [
              Calendars(),
              verticalDivider,
              Team(),
              verticalDivider,
              Notes(),
            ],
          ),
        ),
      ],
    );
  }
}
