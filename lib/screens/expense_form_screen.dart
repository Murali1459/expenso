import 'package:expenso/providers/tag_provider.dart';
import 'package:expenso/screens/widgets/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseFormScreen extends ConsumerWidget {
  const ExpenseFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tgPrd = ref.watch(tagProvider.future);
    return FutureBuilder(
      future: tgPrd,
      builder: (BuildContext ctx, AsyncSnapshot snap) {
        Widget tagWidget = CircularProgressIndicator();
        if (snap.connectionState == ConnectionState.done) {
          // TODO: pass tags here
          tagWidget = Container();
        }
        return AddExpense(tagWidget: tagWidget);
      },
    );
  }
}
