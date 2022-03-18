import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class TopBarSpinner extends StatelessWidget {
  const TopBarSpinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueConnector<_State>(
      converter: (state) {
        return _State(
          hasError: state.eventsState.exception != null,
          isLoading: state.eventsState.isLoading,
        );
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Padding(
            padding: EdgeInsets.only(right: 5),
            child: SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(strokeWidth: 2.8),
            ),
          );
        } else if (state.hasError) {
          return const Padding(
            padding: EdgeInsets.only(right: 2),
            child: Icon(Icons.error, size: 20),
          );
        } else {
          return const Icon(Icons.fiber_manual_record_outlined);
        }
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
