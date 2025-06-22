import 'package:expenso/db/database.dart';
import 'package:expenso/entities/tag.dart';
import 'package:expenso/screens/widgets/tag_chips.dart';
import 'package:flutter/material.dart';

class TagInput extends StatefulWidget {
  const TagInput({super.key});

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  late Future<ExpenseDb> _dbFuture;
  List<TagEntity> selectedTags = [];

  @override
  void initState() {
    super.initState();
    _dbFuture = ExpenseDb.init();
  }

  Widget chipBuilder(BuildContext ctx, AsyncSnapshot<List<TagEntity>> snap) {
    if (snap.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }

    return TagChips(tags: tags);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TagEntity>>(
      future: _dbFuture.then((db) async {
        await Future.delayed(Duration(seconds: 2));
        return db.tagDao.getAllTags();
      }),
      builder: chipBuilder,
    );
  }
}
