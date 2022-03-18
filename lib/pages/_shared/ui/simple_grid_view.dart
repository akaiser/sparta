import 'package:flutter/widgets.dart';

class SimpleGridView extends StatelessWidget {
  const SimpleGridView({
    required this.columnCount,
    required this.rowCount,
    required this.cellBuilder,
    this.cellPadding,
    this.gridBackgroundColor,
    this.cellBackgroundColor,
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

  final double? cellPadding;
  final Color? gridBackgroundColor;
  final Color? cellBackgroundColor;

  @override
  Widget build(BuildContext context) {
    final grid = Column(
      children: List.generate(
        rowCount,
        (yIndex) => Expanded(
          child: Row(
            children: List.generate(
              columnCount,
              (xIndex) {
                final cell = cellBuilder(context, xIndex, yIndex);
                final coloredCell = cellBackgroundColor != null
                    ? ColoredBox(
                        color: cellBackgroundColor!,
                        child: cell,
                      )
                    : cell;

                return Expanded(
                  child: cellPadding != null
                      ? Padding(
                          padding: EdgeInsets.all(cellPadding!),
                          child: coloredCell,
                        )
                      : coloredCell,
                );
              },
            ),
          ),
        ),
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
