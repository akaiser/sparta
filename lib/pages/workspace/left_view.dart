import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/workspace/left/calendars/calendars.dart';
import 'package:sparta/pages/workspace/left/date_controls.dart';
import 'package:sparta/pages/workspace/left/date_picker.dart';
import 'package:sparta/pages/workspace/left/day_names_short.dart';
import 'package:sparta/pages/workspace/left/notes/notes.dart';
import 'package:sparta/pages/workspace/left/team/team.dart';

class LeftView extends StatefulWidget {
  const LeftView({Key? key}) : super(key: key);

  @override
  State<LeftView> createState() => _LeftViewState();
}

class _LeftViewState extends State<LeftView> {
  late final ValueNotifier<DateTime> _pickerDateNotifier;

  @override
  void initState() {
    super.initState();
    _pickerDateNotifier = ValueNotifier(DateTime.now().midDay);
  }

  @override
  void dispose() {
    _pickerDateNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: DateControls(_pickerDateNotifier),
        ),
        verticalDivider,
        const SizedBox(height: 8),
        const DayNamesShort(),
        const SizedBox(height: 8),
        ValueListenableBuilder<DateTime>(
          valueListenable: _pickerDateNotifier,
          builder: (_, pickerDate, __) => DatePicker(pickerDate),
        ),
        Expanded(
          child: ListView(
            children: const [
              verticalDivider,
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
