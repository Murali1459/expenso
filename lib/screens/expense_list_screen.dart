import 'package:expenso/domain/expense.dart' as expense_domain;
import 'package:expenso/providers/chart_provider.dart';
import 'package:expenso/providers/expense_provider.dart';
import 'package:expenso/screens/pie_chart_screen.dart';
import 'package:expenso/screens/widgets/expense_item.dart';
import 'package:expenso/screens/expense_form_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseListScreen extends ConsumerStatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  ConsumerState<ExpenseListScreen> createState() => _ExpenseListState();
}

class _ExpenseListState extends ConsumerState<ExpenseListScreen> {
  List<expense_domain.Expense> _expenses = [];

  @override
  Widget build(BuildContext context) {
    final exp = ref.watch(expenseProvider);
    return exp.when(
      data: futureBuilder,
      error: (e, _) => Text("ERROR $e"),
      loading: () => CircularProgressIndicator(),
    );
  }

  Widget futureBuilder(List<expense_domain.Expense> expense) {
    _expenses = expense;
    if (_expenses.isEmpty) {
      return Center(child: Text("No Expenses Found!"));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _expenses.length,
      itemBuilder: (ctx, ind) {
        return ExpenseItem(
          key: ValueKey(_expenses[ind].id),
          expense: _expenses[ind],
          onDismissed: () => onDismissed(ind),
        );
      },
      separatorBuilder: (_, _) => SizedBox(height: 10),
    );
  }

  void onDismissed(int ind) async {
    expense_domain.Expense e = _expenses[ind];
    setState(() {
      _expenses.removeAt(ind);
    });

    await ref.read(expenseProvider.notifier).remove(e);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense ${e.name} Removed"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "Undo",
          onPressed: () async {
            ScaffoldMessenger.of(context).clearSnackBars();
            await ref.read(expenseProvider.notifier).add(e);
            setState(() {
              _expenses.insert(ind, e);
            });
          },
        ),
      ),
    );
  }
}
