import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/domain/expense.freezed.dart';
part '../generated/domain/expense.g.dart';

@freezed
class Expense with _$Expense {
  factory Expense({
    int? id,

    @Default('') String name,
    @Default('') String transactionDate,
    @Default(0.0) double spent,
    String? note,
  }) = _Expense;

  factory Expense.fromJson(Map<String, Object?> json) =>
      _$ExpenseFromJson(json);
}
