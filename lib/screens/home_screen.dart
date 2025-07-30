import 'package:expenso/providers/expense_provider.dart';
import 'package:expenso/screens/expense_form_screen.dart';
import 'package:expenso/screens/expense_list_screen.dart';
import 'package:expenso/screens/pie_chart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Expenses")),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(215, 0, 0, 0),
        onPressed: () async {
          await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => ExpenseFormScreen()));
          ref.invalidate(expenseProvider);
        },
        child: Icon(CupertinoIcons.add),
      ),
      body: ExpenseListScreen(),
    );
  }
}
