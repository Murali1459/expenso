import 'package:expenso/entities/expense_tag_join.dart';
import 'package:floor/floor.dart';

@dao
abstract class ExpenseTagDao {
  @insert
  Future<void> add(ExpenseTagJoinEntity e);

  @Query("DELETE FROM expense WHERE id = :expenseId")
  Future<void> delete(int expenseId);
}
