import 'package:expenso/providers/tag_provider.dart';
import 'package:expenso/screens/widgets/add_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFormScreen extends ConsumerWidget {
  const ExpenseFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tgPrd = ref.watch(tagProvider.future);
    return FutureBuilder(future: tgPrd, builder: futureBuilder);
  }

  Widget futureBuilder(BuildContext ctx, AsyncSnapshot snap) {
    if (snap.hasError) {
      return Text("Eroor ${snap.error}");
    }
    if (snap.connectionState == ConnectionState.done) {
      return AddExpense(tags: snap.data!);
    }
    return AddExpense(tags: []);
  }
}
