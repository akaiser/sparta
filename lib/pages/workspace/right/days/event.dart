import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';

class Event extends StatelessWidget {
  const Event(this.event, {Key? key}) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: ColoredBox(
        color: Colors.lightGreen,
        child: Row(
          children: [
            Text(
              '${event.id}',
              style: context.tt.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
