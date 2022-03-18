import 'package:flutter/widgets.dart';
import 'package:sparta/pages/workspace/left/date_picker/date_controls.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO cols: 7, rows: 5
    return Column(
      children: const [
        DateControls(),
        // DayNames
        // Days
      ],
    );
  }
}
