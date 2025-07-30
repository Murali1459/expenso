import 'package:expenso/providers/chart_provider.dart';
import 'package:expenso/screens/widgets/charts/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PieChartScreen extends ConsumerStatefulWidget {
  const PieChartScreen({super.key});

  @override
  ConsumerState<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends ConsumerState<PieChartScreen> {
  @override
  Widget build(BuildContext context) {
    var spendAnalysis = ref.watch(chartProvider);
    return spendAnalysis.when(
      data: (d) => PieChart(points: d),
      error: (e, _) => Text("$e"),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
