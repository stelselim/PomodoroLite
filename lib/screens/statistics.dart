import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodorolite/utils/statistics.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fromDate = DateTime.now().subtract(Duration(days: 15));
    final toDate = DateTime.now();

    final date = DateTime.now().subtract(Duration(days: 0));
    final date1 = DateTime.now().subtract(Duration(days: 1));
    final date2 = DateTime.now().subtract(Duration(days: 2));
    final date3 = DateTime.now().subtract(Duration(days: 3));
    final date4 = DateTime.now().subtract(Duration(days: 4));
    final date5 = DateTime.now().subtract(Duration(days: 5));
    final date6 = DateTime.now().subtract(Duration(days: 6));
    final date7 = DateTime.now().subtract(Duration(days: 7));
    final date8 = DateTime.now().subtract(Duration(days: 8));
    final date9 = DateTime.now().subtract(Duration(days: 9));

    return Container(
      alignment: Alignment.center,
      child: StatefulBuilder(
        builder: (context, setState) => FutureBuilder<List<int>>(
            future: getPomodoroStatisticsWithLastTenDays(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CupertinoActivityIndicator();
              }
              if (snapshot.hasError) {
                return Text("Problem");
              }

              final statsList = snapshot.data;
              final todayWorkTime = Duration(minutes: statsList.elementAt(0));
              final yesterdayWorkTime =
                  Duration(minutes: statsList.elementAt(1));

              final lastWeekTime = Duration(
                minutes: statsList.elementAt(0) +
                    statsList.elementAt(1) +
                    statsList.elementAt(2) +
                    statsList.elementAt(3) +
                    statsList.elementAt(4) +
                    statsList.elementAt(5) +
                    statsList.elementAt(6),
              );

              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: BezierChart(
                      bezierChartScale: BezierChartScale.WEEKLY,
                      fromDate: fromDate,
                      toDate: toDate,
                      selectedDate: toDate,
                      series: [
                        BezierLine(
                          label: "WorkTime",
                          data: [
                            DataPoint<DateTime>(
                              value: statsList.elementAt(0).toDouble(),
                              xAxis: date,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(1).toDouble(),
                              xAxis: date1,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(2).toDouble(),
                              xAxis: date2,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(3).toDouble(),
                              xAxis: date3,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(4).toDouble(),
                              xAxis: date4,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(5).toDouble(),
                              xAxis: date5,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(6).toDouble(),
                              xAxis: date6,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(7).toDouble(),
                              xAxis: date7,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(8).toDouble(),
                              xAxis: date8,
                            ),
                            DataPoint<DateTime>(
                              value: statsList.elementAt(9).toDouble(),
                              xAxis: date9,
                            ),
                          ],
                        ),
                      ],
                      config: BezierChartConfig(
                        stepsYAxis: 30,
                        verticalIndicatorStrokeWidth: 3.0,
                        verticalIndicatorColor: Colors.black26,
                        showVerticalIndicator: true,
                        verticalIndicatorFixedPosition: true,
                        displayYAxis: true,
                        physics: ClampingScrollPhysics(),
                        backgroundColor: Colors.blue,
                        footerHeight: 40.0,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ListTile(
                          title: Text("Today Work"),
                          trailing: Text(
                            "${todayWorkTime.inHours} hour(s) ${todayWorkTime.inMinutes - todayWorkTime.inHours * 60} min(s)",
                          ),
                        ),
                        ListTile(
                          title: Text("Yesterday Work"),
                          trailing: Text(
                            "${yesterdayWorkTime.inHours} hour(s) ${yesterdayWorkTime.inMinutes - yesterdayWorkTime.inHours * 60} min(s)",
                          ),
                        ),
                        ListTile(
                          title: Text("Last Week Work"),
                          trailing: Text(
                            "${lastWeekTime.inHours} hour(s) ${lastWeekTime.inMinutes - lastWeekTime.inHours * 60} min(s)",
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Refresh Page
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Refresh",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey.shade600,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
