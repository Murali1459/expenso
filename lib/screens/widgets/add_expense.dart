import 'dart:async';

import 'package:expenso/db/database.dart';
import 'package:expenso/entities/expense.dart';
import 'package:expenso/screens/widgets/tag_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  String? _name, _spent;
  DateTime? _date;
  bool _markAsIncome = false;

  final _formKey = GlobalKey<FormState>();
  final _dateCtrl = TextEditingController();
  late Future<ExpenseDb> _dbFuture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(
        left: 10,
        right: 10,
        top: 50,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 15,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Expense Name",
                hintText: "Groceries",
              ),
              validator: (_) => _name == "" ? "Please add expense name" : null,
              onSaved: (val) => _name = val,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount Spent",
                hintText: "300",
                prefixText: "₹ ",
              ),
              validator: (_) => _spent == 0 ? "Please add amount" : null,
              onSaved: (val) => _spent = val,
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
            ),
            Row(
              spacing: 10,
              children: [
                SizedBox(
                  width: 24,
                  child: Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: _markAsIncome,
                    onChanged: (a) => setState(() {
                      _markAsIncome = a!;
                    }),
                  ),
                ),
                Text("Mark as income"),
              ],
            ),
            Container(child: TagInput(), padding: EdgeInsets.zero),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 8,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Discard"),
                ),
                OutlinedButton(
                  onPressed: () => saveForm(context),
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _dateCtrl.dispose();
  }

  @override
  void initState() {
    super.initState();
    _dbFuture = ExpenseDb.init();
  }

  void saveForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      double spent = double.parse(_spent!);
      ExpenseEntity e = ExpenseEntity(
        name: _name!,
        transactionDate: _dateCtrl.text,
        spent: _markAsIncome ? spent : -spent,
      );

      await _dbFuture.then((db) => db.expenseDao.insertExpense(e));

      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
