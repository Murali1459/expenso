import 'package:floor/floor.dart';

@Entity(tableName: "expense")
class ExpenseEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: "name")
  final String name;
  @ColumnInfo(name: "transactionDate")
  final String transactionDate;
  @ColumnInfo(name: "spent")
  final double spent;
  @ColumnInfo(name: "note")
  final String? note;

  ExpenseEntity({
    this.id,
    required this.name,
    required this.transactionDate,
    required this.spent,
    this.note,
  });
}
