import 'package:expenso/db/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/db.g.dart';

@riverpod
class Db extends _$Db {
  @override
  Future<ExpenseDb> build() => ExpenseDb.init();
}
