import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:sparta/l10n/mappers/month.dart';
import 'package:sparta/pages/_shared/extensions/build_context.dart';
import 'package:sparta/pages/_shared/extensions/date_time.dart';
import 'package:sparta/pages/_shared/state/value_connector.dart';

class ShownRangeText extends StatelessWidget {
  const ShownRangeText({super.key});

  @override
  Widget build(BuildContext context) => ValueConnector<_State>(
        ignoreChange: (state) => state.dayEventsState.isLoading,
        converter: (state) {
          final refDate = state.dayEventsState.refDate;
          final isWorkWeek = state.settingsState.isWorkWeek;
          final endDateSubtractDuration = Duration(days: isWorkWeek ? 2 : 0);
          return _State(
            refDate.startOfWeek,
            refDate.addWeek.endOfWeek.subtract(endDateSubtractDuration),
          );
        },
        builder: (context, state, _) {
          final start = state.start;
          final end = state.end;
          final startMonthText = start.month.toMonth.l10n(context.l10n);
          final endMonthText = end.month.toMonth.l10n(context.l10n);
          return Text(
            start.month == end.month
                ? '${start.day} - ${end.day} $startMonthText'
                : '${start.day} $startMonthText - ${end.day} $endMonthText',
            style: context.tt.bodyMedium,
            overflow: TextOverflow.fade,
            softWrap: false,
          );
        },
      );
}

class _State extends Equatable {
  const _State(this.start, this.end);

  final DateTime start;
  final DateTime end;

  @override
  List<Object?> get props => [start, end];
}
