import 'package:expenso/domain/expense.dart' as expense_domain;
import 'package:expenso/screens/widgets/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseItem extends ConsumerWidget {
  final expense_domain.Expense expense;
  final void Function()? onDismissed;
  const ExpenseItem({super.key, required this.expense, this.onDismissed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onDismissed: (dir) {
        if (dir == DismissDirection.startToEnd && onDismissed != null) {
          onDismissed!();
        }
      },
      key: Key("${expense.id!}"),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.white, width: 0.2),
        ),
        padding: EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsetsGeometry.only(left: 10, right: 10),
              style: ListTileStyle.drawer,
              leading: Icon(
                expense.spent > 0
                    ? CupertinoIcons.arrow_down_circle
                    : CupertinoIcons.arrow_up_circle,
                color: expense.spent > 0 ? Colors.green : Colors.red,
                size: 35,
              ),
              title: Text(expense.name),
              subtitle: Text(expense.transactionDate),
              trailing: Text(
                expense.spent > 0 ? '+₹${expense.spent}' : '₹${-expense.spent}',
                style: TextStyle(
                  fontSize: 16,
                  color: expense.spent > 0 ? Colors.green : null,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 5),
                child: Row(
                  spacing: 5,
                  children: [
                    for (int i = 0; i < 30; i++) Tag(name: "card$i$i$i$i"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
