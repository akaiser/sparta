import 'package:flutter/widgets.dart';

class SimpleGrid extends StatelessWidget {
  const SimpleGrid({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    this.expandColumns = true,
    this.expandRows = true,
    this.leadingOffsetColumnBuilder,
    Key? key,
  })  : assert(columnCount > 0, 'columnCount must be greater than 0'),
        assert(rowCount > 0, 'rowCount must be greater than 0'),
        super(key: key);

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
  Widget build(BuildContext context) {
    return Column(
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

          final row = Row(
            children: [
              if (leadingOffsetColumnBuilder != null)
                leadingOffsetColumnBuilder!(context, yIndex),
              ...cells,
            ],
          );
          return expandRows ? Expanded(child: row) : row;
        },
      ),
    );
  }
}
