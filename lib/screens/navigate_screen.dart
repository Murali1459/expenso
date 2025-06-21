import 'package:expenso/screens/dashboard.dart';
import 'package:expenso/screens/expense_list.dart';
import 'package:flutter/cupertino.dart';

class NavigateScreen extends StatelessWidget {
  final int index;
  const NavigateScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final screens = [ExpenseList(), Dashboard()];
    return screens[index];
  }
}
