/*import 'package:flutter/material.dart';

class WeatherTable extends StatelessWidget {
  final List<Map<String, dynamic>> weatherList;

  WeatherTable({required this.weatherList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 450.0, // Adjust the height as needed
        child: Card(
          color: Color(0xffF7F7F2), // Light gray background color
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Données de la station',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color(0xff92BA92),
                  ),
                ),
              ),
              Divider(
                color: Color(0xff345434),
                thickness: 1.0,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 6.0, // Adjust the column spacing as needed
                      horizontalMargin: 6.0,
                      columns: weatherList.isEmpty
                          ? []
                          : [
                        for (var data in weatherList)
                          DataColumn(
                            label: Container(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      data['name'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff345434),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Color(0xff345434),
                                    thickness: 1.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                      rows: weatherList.isEmpty
                          ? []
                          : List.generate(
                        weatherList[0]['values'].length,
                            (index) => DataRow(
                          cells: [
                            for (var data in weatherList)
                              DataCell(
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      data['values'][index].toString(),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'freeze_panes_dataGridSource.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class WeatherTable extends StatelessWidget {
  
  final List<Map<String, dynamic>> weatherList;

  WeatherTable({required this.weatherList});
  
  final FreezePanesDataGridSource freezePanesDataGridSource =
      FreezePanesDataGridSource(weatherList: []);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 450.0, // Adjust the height as needed
        child: Card(
          color: Color(0xffF7F7F2), // Light gray background color
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Données de la station',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color(0xff92BA92),
                  ),
                ),
              ),
              Divider(
                color: Color(0xff345434),
                thickness: 1.0,
              ),
              Expanded(
                child: SfDataGrid(
                    source: FreezePanesDataGridSource(weatherList: weatherList),
                    frozenColumnsCount: 1,
                    columns: List<GridColumn>.generate(
                      weatherList.length,
                      (index) {
                        final columnName = weatherList[index]['name'];
                        return GridColumn(
                          columnName: columnName,
                          label: Container(
                            height: 20.0,
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              columnName,
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color:const Color(0xff345434),
                              fontSize: 12 ,                    
                            ),
                        ),
                          ),
                      
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}