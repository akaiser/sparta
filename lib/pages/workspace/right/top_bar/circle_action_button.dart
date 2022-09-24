import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/extensions/events.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/states/events_state.dart';

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({super.key});

  @override
  Widget build(BuildContext context) => ValueConnector<_State>(
        converter: (state) => _State(
          hasError: state.eventsState.exception != null,
          isLoading: state.eventsState.isLoading,
        ),
        builder: (context, state, _) => state.isLoading
            ? const _LoadingSpinner()
            : state.hasError
                ? const _ErrorButton()
                : const _ActionButton(),
      );
}

class _ErrorButton extends StatelessWidget {
  const _ErrorButton();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.only(right: 2), // TODO(albert): check
        child: Icon(Icons.error_outline, size: 20),
      );
}

class _LoadingSpinner extends StatelessWidget {
  const _LoadingSpinner();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: SizedBox(
          height: 14,
          width: 14,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton();

  static const _action = FetchEventsAction(EventsActionType.init);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().midDay;
    return ValueConnector<DateTime>(
      ignoreChange: (state) => state.eventsState.isLoading,
      converter: (state) => state.eventsState.refDate,
      builder: (context, refDate, _) {
        final events = context.store.state.eventsState.events;
        final dateIsShown = events.shownEventsContainDate(refDate, now);
        return HoverIconButton(
          Icons.fiber_manual_record_outlined,
          onPressed: dateIsShown ? null : () => context.store.dispatch(_action),
        );
      },
    );
  }
}

class _State extends Equatable {
  const _State({
    required this.hasError,
    required this.isLoading,
  });

  final bool hasError;
  final bool isLoading;

  @override
  List<Object?> get props => [hasError, isLoading];
}
