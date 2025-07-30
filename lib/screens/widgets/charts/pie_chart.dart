import 'package:expenso/domain/point.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  final List<Point> points;
  const PieChart({super.key, required this.points});

  List<DoughnutSeries<ChartPoint, String>> getSampleData() {
    return <DoughnutSeries<ChartPoint, String>>[
      DoughnutSeries<ChartPoint, String>(
        explode: true,
        animationDuration: 300,
        dataSource: [for (Point p in points) ChartPoint(x: p.x, y: p.y)],
        xValueMapper: (a, _) => a.x,
        yValueMapper: (a, _) => a.y,
        dataLabelMapper: (d, _) => "₹${d.y}",
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.outside,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SfCircularChart(
        title: ChartTitle(text: "Chart"),
        series: getSampleData(),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
        ),
      ),
    );
  }
}
