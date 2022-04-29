import 'package:flutter/widgets.dart';

class SimpleGridView extends StatelessWidget {
  const SimpleGridView({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    this.expandColumns = true,
    this.expandRows = true,
    this.cellPadding,
    this.gridBackgroundColor,
    Key? key,
  })  : assert(columnCount > 0),
        assert(rowCount > 0),
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
  final double? cellPadding;
  final Color? gridBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final grid = Column(
      children: List.generate(
        rowCount,
        (yIndex) {
          final row = Row(
            children: List.generate(
              columnCount,
              (xIndex) {
                final cell = cellBuilder(context, xIndex, yIndex);
                final paddedCell = cellPadding != null
                    ? Padding(
                        padding: EdgeInsets.all(cellPadding!),
                        child: cell,
                      )
                    : cell;
                return expandColumns ? Expanded(child: paddedCell) : paddedCell;
              },
            ),
          );
          return expandRows ? Expanded(child: row) : row;
        },
      ),
    );
    final paddedGrid = cellPadding != null
        ? Padding(
            padding: EdgeInsets.all(cellPadding!),
            child: grid,
          )
        : grid;

    return gridBackgroundColor != null
        ? ColoredBox(
            color: gridBackgroundColor!,
            child: paddedGrid,
          )
        : paddedGrid;
  }
}
