import 'package:flutter/material.dart';
import 'package:pathfinder/services/results_service.dart';
import 'package:two_dimensional_scrollables/two_dimensional_scrollables.dart';

class ResultItemScreen extends StatelessWidget {
  final Result result;
  const ResultItemScreen({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxColumns = result.field.first.length;
    for (final row in result.field) {
      if (row.length > maxColumns) maxColumns = row.length;
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        backgroundColor: Colors.blueAccent,
        title: Container(
          child: Text(
            'Preview screen',
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 20,
            child: TableView.builder(
              columnCount: maxColumns,
              rowCount: result.field.length,
              columnBuilder: (_) => const TableSpan(extent: FixedTableSpanExtent(60)),
              rowBuilder: (_) => const TableSpan(extent: FixedTableSpanExtent(60)),
              cellBuilder: (context, coords) {
                return TableViewCell(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: getCellColor(coords.column, coords.row),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Text('${coords.column},${coords.row}'),
                  ),
                );
              },
            ),
          ),
          Text(result.stringPath),
        ],
      ),
    );
  }

  Color getCellColor(int x, int y) {
    if (result.start.x == x && result.start.y == y) return const Color(0xFF64FFDA);
    if (result.end.x == x && result.end.y == y) return const Color(0xFF009688);
    if (result.field[y][x] == 0) return const Color(0xFF000000);
    // since this screen is not updateable for now, add optimization for colors later
    for (final point in result.path) {
      if (point.x == x && y == point.y) return const Color(0xFF4CAF50);
    }
    return const Color(0xFFFFFFFF);
  }
}
