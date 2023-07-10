import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weatherList;
  final int yAxisIndex;
  final String title;

  LineChartWidget({required this.weatherList, required this.yAxisIndex, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 450.0, // Adjust the height as needed
        child: Card(
          color: Color(0xffF7F7F2), 
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff92BA92),
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(
                color: Color(0xff345434),
                thickness: 1.0,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: weatherList[0]['values'].length.toDouble() - 1,
                      minY: weatherList[yAxisIndex]['values'].whereType<num>().reduce((num min, num value) => min < value ? min : value),
                      maxY: weatherList[yAxisIndex]['values'].whereType<num>().reduce((num max, num value) => max > value ? max : value),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 80, // Adjust the reserved size as needed
                          getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff4D7F4D),
                            fontSize: 10,
                          ),
                          getTitles: (value) {
                            if (value.toInt() >= 0 && value.toInt() < weatherList[0]['values'].length) {
                              return weatherList[0]['values'][value.toInt()];
                            }
                            return '';
                          },
                          margin: 8,
                          rotateAngle: -80,
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          getTextStyles: (context, value) => const TextStyle(
                            color: Color(0xff4D7F4D),
                            fontSize: 14,
                          ),
                          getTitles: (value) {
                            return value.toInt().toString();
                          },
                          margin: 8,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Color(0xff345434), width: 1),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: List.generate(
                            weatherList[0]['values'].length,
                            (index) => FlSpot(
                              index.toDouble(),
                              weatherList[yAxisIndex]['values'][index].toDouble(),
                            ),
                          ),
                          isCurved: true,
                          colors: const [Color(0xffFFBC75)],
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: true),
                          belowBarData: BarAreaData(show: false),
                        ),
                      ],
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
}
