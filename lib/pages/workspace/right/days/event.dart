import 'package:flutter/material.dart';
import 'package:sparta/_themes.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/iterable.dart';
import 'package:sparta/pages/_shared/models/event_model.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/bordered.dart';
import 'package:sparta/pages/_shared/ui/clickable_region.dart';
import 'package:sparta/states/focussed_event_state.dart';

const _eventHeight = 24.0;
const _eventBadgeWidth = 7.0;
const _eventBadgeHeight = _eventHeight - 4;

const _itemsSpacer = SizedBox(width: 2);

class Event extends StatelessWidget {
  const Event(
    this.event, {
    required this.onNotFocussedDateTap,
    super.key,
  });

  final EventModel event;
  final ValueSetter<BuildContext> onNotFocussedDateTap;

  // TODO(albert): badges will be part of an event later
  static const badges = <Widget>[
    _Badge(Colors.redAccent),
    _Badge(Colors.black),
  ];

  void _onEventTap(BuildContext context) {
    onNotFocussedDateTap(context);
    context.store.dispatch(FocusEventAction(event.id));
  }

  @override
  Widget build(BuildContext context) {
    const eventColor = urlaub; // TODO(albert): fix color
    return Tooltip(
      message: 'Hello \nWorld!\n\nbla',
      waitDuration: const Duration(milliseconds: 700),
      child: ClickableRegion(
        child: ValueConnector<bool>(
          converter: (state) => state.focussedEventState.eventId == event.id,
          builder: (context, isFocussed, child) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: isFocussed ? null : () => _onEventTap(context),
            onSecondaryTap: () {
              _onEventTap(context);
              // TODO(albert): open right click menu(edit, delete, copy)
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: ColoredBox(
                color: isFocussed ? eventColor.withOpacity(0.6) : eventColor,
                child: child,
              ),
            ),
          ),
          child: SizedBox(
            height: _eventHeight,
            child: Row(
              children: [
                _itemsSpacer,
                Expanded(
                  child: Text(
                    '${event.id}',
                    style: context.tt.labelSmall,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
                _itemsSpacer,
                ...badges.append(_itemsSpacer),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Badge extends Bordered {
  const _Badge(super.backgroundColor)
      : super(
          child: const SizedBox(
            width: _eventBadgeWidth,
            height: _eventBadgeHeight,
          ),
        );
}
