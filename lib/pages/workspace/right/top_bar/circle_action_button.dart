import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';
import 'package:sparta/pages/_shared/ui/hover_icon_button.dart';
import 'package:sparta/pages/_shared/ui/loading_spinner.dart';
import 'package:sparta/states/day_events_state.dart';

class CircleActionButton extends StatelessWidget {
  const CircleActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().midDay;
    return ValueConnector<_State>(
      converter: (state) {
        final dayEventsState = state.dayEventsState;
        return _State(
          isLoading: dayEventsState.isLoading,
          exception: dayEventsState.exception,
          dayIsShown: dayEventsState.shownEventsContainDate(now),
        );
      },
      builder: (context, state, _) => state.isLoading
          ? const _LoadingSpinner()
          : state.exception != null
              ? _ErrorButton(state.exception)
              : _ActionButton(dayIsShown: state.dayIsShown),
    );
  }
}

class _ErrorButton extends StatelessWidget {
  const _ErrorButton(this.exception);

  // TODO(albert): decide how to show and resolve the issue
  final Exception? exception;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Icon(
          Icons.error_outline,
          size: 20,
          color: context.td.errorColor,
        ),
      );
}

class _LoadingSpinner extends StatelessWidget {
  const _LoadingSpinner();

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: LoadingSpinner(),
      );
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.dayIsShown});

  final bool dayIsShown;

  static const _action = FetchDayEventsAction(DayEventsActionType.init);

  @override
  Widget build(BuildContext context) => HoverIconButton(
        Icons.fiber_manual_record_outlined,
        onPressed: dayIsShown ? null : () => context.store.dispatch(_action),
      );
}

class _State extends Equatable {
  const _State({
    required this.isLoading,
    required this.exception,
    required this.dayIsShown,
  });

  final bool isLoading;
  final Exception? exception;
  final bool dayIsShown;

  @override
  List<Object?> get props => [isLoading, exception, dayIsShown];
}
