import 'package:expenso/providers/expense_form_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFields extends ConsumerStatefulWidget {
  const ExpenseFields({super.key});

  @override
  ConsumerState<ExpenseFields> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends ConsumerState<ExpenseFields> {
  String? _name, _spent;

  DateTime? _date;
  final _dateCtrl = TextEditingController();

  bool _markAsIncome = false;

  @override
  void dispose() {
    super.dispose();
    _dateCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Expense Name",
            hintText: "Groceries",
          ),
          validator: (_) =>
              (_name == "" || _name == null) ? "Please add expense name" : null,
          onSaved: (val) =>
              ref.read(expenseFormProvider.notifier).setName(val!),
          onChanged: (v) => _name = v,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Amount Spent",
            hintText: "300",
            prefixText: "₹ ",
          ),
          validator: (_) => (_spent == null || double.parse(_spent!) == 0.0)
              ? "Please add amount"
              : null,
          onSaved: (val) {
            double dval = double.parse(val!);
            if (!_markAsIncome) dval *= -1;
            ref.read(expenseFormProvider.notifier).setSpent(dval);
          },
          onChanged: (v) => _spent = v,
        ),
        TextFormField(
          decoration: InputDecoration(
            icon: Icon(CupertinoIcons.calendar_today),
            labelText: "Enter Date",
          ),
          readOnly: true,
          controller: _dateCtrl,
          onTap: () async {
            DateTime? d = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 1000)),
              lastDate: DateTime.now().subtract(Duration(days: -1000)),
            );
            setState(() {
              _date = d;
              _dateCtrl.text = "${d!.day}/${d.month}/${d.year}";
            });
          },
          validator: (_) => _date == null ? 'Pick a date' : null,
          onSaved: (val) =>
              ref.read(expenseFormProvider.notifier).setTransactionDate(val!),
        ),
        Row(
          spacing: 10,
          children: [
            SizedBox(
              width: 24,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _markAsIncome,
                onChanged: (val) {
                  if (val == null) return;
                  setState(() {
                    _markAsIncome = val;
                  });
                },
              ),
            ),
            Text("Mark as income", style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
