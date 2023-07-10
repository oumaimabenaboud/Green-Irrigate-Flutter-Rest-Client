import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class FreezePanesDataGridSource extends DataGridSource {
  final List<Map<String, dynamic>> weatherList;

  FreezePanesDataGridSource({required this.weatherList});

  @override
  List<DataGridRow> get rows {
    final List<DataGridRow> gridRows = [];

    final columnNameList = weatherList.map((data) => data['name']).toList();
    final maxValuesCount = weatherList.map((data) => data['values'].length).reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < maxValuesCount; i++) {
      final List<DataGridCell<dynamic>> cells = [];

      for (final columnName in columnNameList) {
        final data = weatherList.firstWhere((item) => item['name'] == columnName);
        final values = data['values'];

        cells.add(DataGridCell<dynamic>(
          columnName: columnName,
          value: i < values.length ? values[i].toString() : '',
        ));
      }

      gridRows.add(DataGridRow(cells: cells));
    }

    return gridRows;
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final rowData = row.getCells();

    return DataGridRowAdapter(
      cells: rowData.map<Widget>((cell) {
        return Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            cell.value != null ? cell.value.toString() : '',
          ),
        );
      }).toList(),
    );
  }
}