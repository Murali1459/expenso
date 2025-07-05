import 'package:expenso/domain/expense.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/expense_form_provider.g.dart';

@riverpod
class ExpenseForm extends _$ExpenseForm {
  @override
  Expense build() => Expense();

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setSpent(double spent) {
    state = state.copyWith(spent: spent);
  }

  void setTransactionDate(String td) {
    state = state.copyWith(transactionDate: td);
  }
}
