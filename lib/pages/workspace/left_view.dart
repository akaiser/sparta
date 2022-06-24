import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/workspace/left/calendars/calendars.dart';
import 'package:sparta/pages/workspace/left/date_picker.dart';
import 'package:sparta/pages/workspace/left/notes/notes.dart';
import 'package:sparta/pages/workspace/left/team/team.dart';

class LeftView extends StatelessWidget {
  const LeftView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
