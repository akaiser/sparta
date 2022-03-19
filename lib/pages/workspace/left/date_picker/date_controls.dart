import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/ui/base_icon_button.dart';

class DateControls extends StatelessWidget {
  const DateControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BaseIconButton(Icons.chevron_left, onPressed: () {}),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  'Jan',
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.bodyMedium,
                ),
              ),
            ),
            BaseIconButton(Icons.chevron_right, onPressed: () {}),
            BaseIconButton(
              Icons.fiber_manual_record_outlined,
              onPressed: () {},
            ),
            BaseIconButton(Icons.chevron_left, onPressed: () {}),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  '2022',
                  overflow: TextOverflow.ellipsis,
                  style: context.tt.bodyMedium,
                ),
              ),
            ),
            BaseIconButton(Icons.chevron_right, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
