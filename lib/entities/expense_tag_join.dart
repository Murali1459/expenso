import 'package:expenso/entities/expense.dart';
import 'package:expenso/entities/tag.dart';
import 'package:floor/floor.dart';

@Entity(
  tableName: 'expense_tag_join',
  primaryKeys: ['expenseId', 'tagId'],
  foreignKeys: [
    ForeignKey(
      childColumns: ['expenseId'],
      parentColumns: ['id'],
      entity: ExpenseEntity,
    ),
    ForeignKey(
      childColumns: ['tagId'],
      parentColumns: ['id'],
      entity: TagEntity,
    ),
  ],
)
class ExpenseTagJoinEntity {
  @ColumnInfo()
  final int expenseId;
  @ColumnInfo()
  final int tagId;

  ExpenseTagJoinEntity({required this.expenseId, required this.tagId});
}
