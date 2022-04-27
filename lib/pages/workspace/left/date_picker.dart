import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_picker_controls.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_picker_days.dart';
import 'package:sparta/pages/workspace/left/date_picker/day_names_short.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
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
          child: DatePickerControls(_pickerDateNotifier),
        ),
        verticalDivider,
        const SizedBox(height: 8),
        const DayNamesShort(),
        const SizedBox(height: 8),
        ValueListenableBuilder<DateTime>(
          valueListenable: _pickerDateNotifier,
          builder: (_, pickerDate, __) => DatePickerDays(pickerDate),
        ),
      ],
    );
  }
}
