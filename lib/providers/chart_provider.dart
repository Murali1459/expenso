import 'package:expenso/domain/point.dart';
import 'package:expenso/providers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/chart_provider.g.dart';

@riverpod
class Chart extends _$Chart {
  @override
  Future<List<Point>> build() async {
    final db = await ref.read(dbProvider.future);
    List<Map<String, dynamic>> res = await db.executeRawQuery('''
		select SUM(CASE WHEN spent > 0 THEN spent else 0 END) as income,
		SUM(CASE WHEN spent < 0 THEN spent else 0 END) as expenditure
		from expense;
	''');
    num income = res[0]["income"] as num;
    num expenditure = res[0]["expenditure"] as num;
    return [
      Point(x: "Income", y: income.toDouble()),
      Point(x: "Expenditure", y: -1 * expenditure.toDouble()),
    ];
  }
}
