import 'package:flutter/material.dart';
import 'package:orcun_math/models/target_list_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HomePageChartField extends StatefulWidget {
  const HomePageChartField({
    Key? key,
    required this.targetList,
    required this.backColor,
  }) : super(key: key);

  final List<TargetListModel> targetList;
  final bool backColor;

  @override
  State<HomePageChartField> createState() => _HomePageChartFieldState();
}

class _HomePageChartFieldState extends State<HomePageChartField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: /*SfCircularChart(
              series: <CircularSeries>[
                RadialBarSeries<TargetListModel, String>(
                    dataSource: widget.targetList,
                    xValueMapper: (TargetListModel _results, _) =>
                        _results.date?.substring(0, 10),
                    yValueMapper: (TargetListModel _results, _) =>
                        _results.result,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    maximumValue: 100),
              ],
            ),*/
                SfCartesianChart(
              series: <ChartSeries>[
                StackedAreaSeries<TargetListModel, dynamic>(
                  dataSource: widget.targetList,
                  xValueMapper: (TargetListModel _results, _) => _,
                  yValueMapper: (TargetListModel _results, _) =>
                      _results.result,
                  color: widget.backColor ? Colors.green : Colors.red,
                  opacity: 0.6,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
