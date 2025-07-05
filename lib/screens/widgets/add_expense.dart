import 'package:expenso/providers/expense_form_provider.dart';
import 'package:expenso/providers/expense_provider.dart';
import 'package:expenso/screens/widgets/text_fields_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expenso/domain/expense.dart' as expense_domain;

class AddExpense extends ConsumerWidget {
  final Widget tagWidget;
  AddExpense({super.key, required this.tagWidget});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 10, right: 10, top: 50),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 15,
            children: [
              ExpenseFields(),
              tagWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Discard"),
                  ),
                  OutlinedButton(
                    onPressed: () => saveForm(context, ref),
                    child: Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveForm(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      expense_domain.Expense e = ref.read(expenseFormProvider);
      await ref.read(expenseProvider.notifier).add(e);

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
