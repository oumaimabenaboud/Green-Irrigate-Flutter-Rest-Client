
import 'package:flutter/material.dart';
import 'package:my_app/services/auth.dart';
import 'package:intl/intl.dart';
import 'package:my_app/ui/widgets/weather_table.dart';
import 'package:my_app/ui/widgets/line_chart.dart';
import 'package:my_app/services/data_service.dart';

class HomeScreen extends StatefulWidget {
    @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> weatherList = [];
  DateTime minDate = DateTime.now();
  DateTime maxDate = DateTime.now();
  AuthBase authBase = AuthBase();
    @override
  void initState() {
    super.initState();
    minDate = DateTime(2023, 5, 22);
    maxDate = DateTime(2023, 5, 23);
    fetchData();
  }
    Future<void> fetchData() async {
    final dataService = DataService();
    weatherList = await dataService.getData(minDate, maxDate);
    setState(() {}); // Trigger a rebuild after data is fetched
  }

  void updateMinDate(DateTime newMinDate) {
    setState(() {
      minDate = newMinDate;
    });
  }

  void updateMaxDate(DateTime newMaxDate) {
    setState(() {
      maxDate = newMaxDate;
    });
  }

  void onFilterButtonPressed() async {
    final dataService = DataService();
    weatherList = await dataService.getData(minDate, maxDate);
    setState(() {});
    print('Min Date: $minDate');
    print('Max Date: $maxDate');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          child: Text('Sign out',
          style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Color(0xff92BA92),
                  ),),
          onPressed: () async {
            await authBase.logout();
            Navigator.of(context).pushReplacementNamed('login');
          },
        ),
      ),
   body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text('Min Date:'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: minDate,
                              firstDate: DateTime(2018, 07, 26),
                              lastDate: maxDate,
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                updateMinDate(selectedDate);
                              }
                            });
                          },
                          child: Text(
                            '${DateFormat('dd/MM/yyyy').format(minDate)}',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(minDate),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                final newMinDate = DateTime(
                                  minDate.year,
                                  minDate.month,
                                  minDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                updateMinDate(newMinDate);
                              }
                            });
                          },
                          child: Text(
                            '${DateFormat('HH:mm').format(minDate)}',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Text('Max Date:'),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: maxDate,
                              firstDate: minDate,
                              lastDate: DateTime(2023, 05, 23),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                updateMaxDate(selectedDate);
                              }
                            });
                          },
                          child: Text(
                            '${DateFormat('dd/MM/yyyy').format(maxDate)}',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        GestureDetector(
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(maxDate),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                final newMaxDate = DateTime(
                                  maxDate.year,
                                  maxDate.month,
                                  maxDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                updateMaxDate(newMaxDate);
                              }
                            });
                          },
                          child: Text(
                            '${DateFormat('HH:mm').format(maxDate)}',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                    onPressed: onFilterButtonPressed,
                    child: Text('Rafraîchir'),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              weatherList.isEmpty
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        WeatherTable(weatherList: weatherList),
                        LineChartWidget(
                            weatherList: weatherList,
                            yAxisIndex: 1,
                            title: 'Température [°C]',
                          ),
                        
                      ],
                    ),
              SizedBox(height: 16.0),
              weatherList.isEmpty
                  ? CircularProgressIndicator()
                  : Row(
                      children: [
                        LineChartWidget(
                            weatherList: weatherList,
                            yAxisIndex: 4,
                            title: 'Point de rosée [°C]'),
                        LineChartWidget(
                            weatherList: weatherList,
                            yAxisIndex: 5,
                            title: 'Rayonnement solaire [W/m²]'),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
