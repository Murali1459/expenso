import 'package:expenso/domain/tag.dart';
import 'package:expenso/entities/mapper/expense_mapper.dart';
import 'package:expenso/domain/expense.dart' as expense_domain;
import 'package:expenso/providers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';

part '../generated/providers/expense_provider.g.dart';

@riverpod
class Expense extends _$Expense {
  @override
  Future<List<expense_domain.Expense>> build() async {
    return executeRaw();
  }

  Future<int> add(expense_domain.Expense e) async {
    final db = await ref.read(dbProvider.future);
    return db.expenseDao.insertExpense(e.toEntity());
  }

  Future<void> remove(expense_domain.Expense e) async {
    final db = await ref.read(dbProvider.future);
    return db.expenseDao.removeExpense(e.toEntity());
  }

  Future<expense_domain.Expense?> getId(int id) async {
    final db = await ref.read(dbProvider.future);
    final entity = await db.expenseDao.getId(id);
    if (entity == null) return null;
    return entity.toDomain();
  }

  Future<List<expense_domain.Expense>> executeRaw() async {
    final db = await ref.read(dbProvider.future);
    var res = await db.executeRawQuery('''
			SELECT e.*,GROUP_CONCAT(tagId) as tagIds, 
			GROUP_CONCAT(t.name) as tagNames from expense e
			left join expense_tag_join et on et.expenseId = e.id 
			left join tag t on t.id = et.tagId group by e.id
''');
    List<expense_domain.Expense> expenses = [];
    for (var expense in res) {
      List<String> tagIds = [], tagNames = [];
      if (expense["tagIds"] != null) {
        tagIds = (expense['tagIds'] as String).split(",");
        tagNames = (expense['tagNames'] as String).split(",");
      }
      List<Tag> tags = [];
      for (int i = 0; i < tagIds.length; i++) {
        tags.add(Tag(id: int.parse(tagIds[i]), name: tagNames[i]));
      }
      expense_domain.Expense e = expense_domain.Expense.fromJson(expense);
      print("adding $e");
      expenses.add(e.copyWith(tags: tags));
    }
    return expenses;
  }

  Future<void> showTags() async {
    final db = await ref.read(dbProvider.future);
    var res = await db.executeRawQuery('''
			select * from tag
''');
    var res1 = await db.executeRawQuery('''
			select * from expense
''');
    var res2 = await db.executeRawQuery('''
			select * from expense_tag_join
''');
    print("tags: $res");
    print("exp: $res1");
    print("exp: $res2");
  }
}
