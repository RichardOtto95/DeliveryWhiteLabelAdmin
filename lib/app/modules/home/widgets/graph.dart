import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../shared/utilities.dart';

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

class Graph extends StatefulWidget {
  Graph({Key? key}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  late TooltipBehavior _tooltip = TooltipBehavior(enable: true);

  List<_ChartData> data = [
    _ChartData('CHN', 12),
    _ChartData('GER', 15),
    _ChartData('RUS', 30),
    _ChartData('BRZ', 6.4),
    _ChartData('IND', 14)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: wXD(10, context, ws: 0)),
      width: wXD(297, context, ws: 427, mediaWeb: true),
      height: wXD(225, context, ws: 327, mediaWeb: true),
      decoration: BoxDecoration(
          color: getColors(context).surface,
          borderRadius: BorderRadius.all(Radius.circular(wXD(9, context)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: wXD(10, context), top: wXD(7, context)),
            child: Text(
              "Clientes",
              style: textFamily(context),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: wXD(17, context),
              right: wXD(15, context),
              // bottom: wXD(7, context),
            ),
            width: wXD(265, context, ws: 390, mediaWeb: true),
            height: wXD(195, context, ws: 272, mediaWeb: true),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                  dataSource: data,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  name: 'Gold',
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff5DC3E7),
                      Color(0xff69DAC5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
