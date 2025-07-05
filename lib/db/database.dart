import 'package:expenso/entities/expense.dart';
import 'package:expenso/entities/expense_tag_join.dart';
import 'package:expenso/entities/tag.dart';
import 'package:expenso/repository/expense_dao.dart';
import 'package:expenso/repository/tag_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part '../generated/db/database.g.dart';

@Database(
  version: 1,
  entities: [ExpenseEntity, TagEntity, ExpenseTagJoinEntity],
)
abstract class ExpenseDb extends FloorDatabase {
  ExpenseDAO get expenseDao;
  TagDao get tagDao;

  static Future<ExpenseDb> init() async {
    return await $FloorExpenseDb.databaseBuilder('expense.db').build();
  }
}
