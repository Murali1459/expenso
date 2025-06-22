import 'package:expenso/db/database.dart';
import 'package:expenso/screens/widgets/add_expense.dart';
import 'package:expenso/screens/widgets/tag_chips.dart';
import 'package:flutter/material.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  late Future<ExpenseDb> _dbFuture;
	@override
	void initState(){
		_dbFuture = ExpenseDb.init();
	}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dbFuture.then((db) => db.tagDao.getAllTags()),
      builder: (BuildContext ctx, AsyncSnapshot snap) {
        Widget tagWidget = CircularProgressIndicator();
        if (snap.connectionState == ConnectionState.done) {
          tagWidget = TagChips(tags: snap.data);
        }
        return AddExpense(tagWidget: tagWidget);
      },
    );
  }
}
