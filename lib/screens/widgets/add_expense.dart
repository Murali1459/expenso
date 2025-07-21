import 'package:expenso/providers/expense_form_provider.dart';
import 'package:expenso/providers/expense_provider.dart';
import 'package:expenso/providers/expense_tag_provider.dart';
import 'package:expenso/screens/widgets/add_tag.dart';
import 'package:expenso/screens/widgets/custom_chip.dart';
import 'package:expenso/screens/widgets/text_fields_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expenso/domain/expense.dart' as expense_domain;
import 'package:expenso/domain/tag.dart' as tag_domain;

class AddExpense extends ConsumerStatefulWidget {
  final List<tag_domain.Tag> tags;
  const AddExpense({super.key, required this.tags});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  final _formKey = GlobalKey<FormState>();
  List<tag_domain.Tag> _tags = [];

  @override
  void didUpdateWidget(covariant AddExpense oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tags != widget.tags) {
      setState(() {
        _tags = widget.tags;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 10, right: 10, top: 50),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              children: [
                ExpenseFields(),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (int i = 0; i < _tags.length; i++)
                      CustomChip(
                        key: ValueKey(_tags[i].id),
                        selected: _tags[i].selected,
                        label: _tags[i].name,
                        onSelect: (val) {
                          setState(() {
                            _tags = List.of(_tags);
                            _tags[i] = _tags[i].copyWith(selected: val);
                          });
                        },
                      ),
                    IconButton.outlined(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (ctx) => AddTag(),
                        );
                      },
                      icon: Icon(CupertinoIcons.add),
                    ),
                  ],
                ),
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
      ),
    );
  }

  void saveForm(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      expense_domain.Expense e = ref.read(expenseFormProvider);
      final id = await ref.read(expenseProvider.notifier).add(e);
      await ref.read(expenseTagProvider.notifier).add(id, getSelectedTags());

      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  List<tag_domain.Tag> getSelectedTags() {
    return _tags.where((t) => t.selected).toList();
  }
}
