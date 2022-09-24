import 'package:flutter/widgets.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_picker_body.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_picker_controls.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_picker_header.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

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
  Widget build(BuildContext context) => ValueConnector<bool>(
        converter: (state) => state.eventsState.isLoading,
        builder: (_, isLoading, child) => AbsorbPointer(
          absorbing: isLoading,
          child: child,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: DatePickerControls(_pickerDateNotifier),
            ),
            verticalDivider,
            const SizedBox(height: 8),
            const DatePickerHeader(),
            const SizedBox(height: 9),
            ValueListenableBuilder<DateTime>(
              valueListenable: _pickerDateNotifier,
              builder: (_, pickerDate, __) => DatePickerBody(pickerDate),
            ),
          ],
        ),
      );
}
