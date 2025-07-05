import 'package:expenso/entities/mapper/expense_mapper.dart';
import 'package:expenso/domain/expense.dart' as expense_domain;
import 'package:expenso/providers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part '../generated/providers/expense_provider.g.dart';

@riverpod
class Expense extends _$Expense {
  List<expense_domain.Expense>? _expenses;
  @override
  Future<List<expense_domain.Expense>> build() async {
    final db = await ref.read(dbProvider.future);
    final entities = await db.expenseDao.getAllExpenses();
    _expenses = entities.map((l) => l.toDomain()).toList();
    return _expenses!;
  }

  Future<void> add(expense_domain.Expense e) async {
    final db = await ref.read(dbProvider.future);
    return db.expenseDao.insertExpense(e.toEntity());
  }

  Future<void> remove(expense_domain.Expense e) async {
    final db = await ref.read(dbProvider.future);
    return db.expenseDao.removeExpense(e.toEntity());
  }

  Future<expense_domain.Expense?> getId(int id) async {
    final db = await ref.read(dbProvider.future);
    final entity = await db.expenseDao.getId(id);
    if (entity == null) return null;
    return entity.toDomain();
  }
}
