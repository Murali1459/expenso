import 'package:expenso/domain/expense.dart';
import 'package:expenso/entities/expense.dart';

extension ExpenseEntityMapper on ExpenseEntity {
  Expense toDomain() => Expense(
    id: id,
    name: name,
    transactionDate: transactionDate,
    note: note,
    spent: spent,
  );
}

extension ExpenseDomainMapper on Expense {
  ExpenseEntity toEntity() => ExpenseEntity(
    id: id,
    name: name,
    transactionDate: transactionDate,
    spent: spent,
    note: note,
  );
}
