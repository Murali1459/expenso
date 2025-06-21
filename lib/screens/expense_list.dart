import 'package:expenso/db/database.dart';
import 'package:expenso/entities/expense.dart';
import 'package:expenso/screens/widgets/add_expense.dart';
import 'package:expenso/screens/widgets/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  late Future<ExpenseDb> _dbFuture;
  late List<ExpenseEntity> _expenses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(215, 0, 0, 0),
        onPressed: () async {
          bool newExpenseAdded = await showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) => AddExpense(),
          );
          if (newExpenseAdded) {
            setState(() {});
          }
        },
        child: Icon(CupertinoIcons.add),
      ),
      body: FutureBuilder<List<ExpenseEntity>>(
        future: _dbFuture.then((db) => db.expenseDao.getAllExpenses()),
        builder: futureBuilder,
      ),
    );
  }

  Widget futureBuilder(
    BuildContext ctx,
    AsyncSnapshot<List<ExpenseEntity>> snap,
  ) {
    if (snap.hasError) {
      return Text("Error has occured ${snap.error}");
    }

    if (snap.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    _expenses = snap.connectionState == ConnectionState.done ? snap.data! : [];
    if (_expenses.isEmpty) {
      return Center(child: Text("No Expenses Found!"));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: _expenses.length,
      itemBuilder: (ctx, ind) => ExpenseItem(
        expense: _expenses[ind],
        onDismissed: (dir) {
          onDismissed(dir, ind);
        },
      ),
      separatorBuilder: (_, _) => SizedBox(height: 10),
    );
  }

  @override
  void initState() {
    super.initState();
    _dbFuture = ExpenseDb.init();
  }

  void onDismissed(DismissDirection dir, int ind) {
    if (dir == DismissDirection.startToEnd) {
      ExpenseEntity e = _expenses[ind];
      _dbFuture.then((db) => db.expenseDao.removeExpense(e));
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Expense Removed"),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              _dbFuture.then((db) => db.expenseDao.insertExpense(e));
              setState(() {});
            },
          ),
        ),
      );
    }
  }
}
