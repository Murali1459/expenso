import 'package:expenso/entities/expense.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExpenseDAO {
  @Query("SELECT * from expense")
  Future<List<ExpenseEntity>> getAllExpenses();

  @Insert()
  Future<void> insertExpense(ExpenseEntity e);

  @delete
  Future<void> removeExpense(ExpenseEntity e);
}
