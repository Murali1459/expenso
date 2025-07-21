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
      onDelete: ForeignKeyAction.cascade,
    ),
    ForeignKey(
      childColumns: ['tagId'],
      parentColumns: ['id'],
      entity: TagEntity,
    ),
  ],
)
class ExpenseTagJoinEntity {
  final int expenseId;
  final int tagId;

  ExpenseTagJoinEntity({required this.expenseId, required this.tagId});
}
