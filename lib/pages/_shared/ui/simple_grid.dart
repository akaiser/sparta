import 'package:flutter/widgets.dart';

class SimpleGrid extends StatelessWidget {
  const SimpleGrid({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    this.expandColumns = true,
    this.expandRows = true,
    this.leadingOffsetColumnBuilder,
    super.key,
  })  : assert(columnCount > 0, 'columnCount must be greater than 0'),
        assert(rowCount > 0, 'rowCount must be greater than 0');

  final int columnCount;
  final int rowCount;

  final Widget Function(
    BuildContext context,
    int xIndex,
    int yIndex,
  ) cellBuilder;

  final bool expandColumns;
  final bool expandRows;

  final Widget Function(
    BuildContext context,
    int yIndex,
  )? leadingOffsetColumnBuilder;

  @override
  Widget build(BuildContext context) => Column(
        children: List.generate(
          rowCount,
          (yIndex) {
            final cells = List.generate(
              columnCount,
              (xIndex) {
                final cell = cellBuilder(context, xIndex, yIndex);
                return expandColumns ? Expanded(child: cell) : cell;
              },
            );

            final leadingOffsetColumnBuilderCopy = leadingOffsetColumnBuilder;
            final row = Row(
              children: [
                if (leadingOffsetColumnBuilderCopy != null)
                  leadingOffsetColumnBuilderCopy(context, yIndex),
                ...cells,
              ],
            );
            return expandRows ? Expanded(child: row) : row;
          },
        ),
      );
}
