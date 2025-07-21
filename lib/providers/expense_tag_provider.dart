import 'package:expenso/entities/expense_tag_join.dart';
import 'package:expenso/entities/mapper/tag_mapper.dart';
import 'package:expenso/entities/tag.dart';
import 'package:expenso/providers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:expenso/domain/tag.dart' as tag_domain;

part '../generated/providers/expense_tag_provider.g.dart';

@riverpod
class ExpenseTag extends _$ExpenseTag {
  @override
  Future<List<tag_domain.Tag>> build() async {
    final db = await ref.read(dbProvider.future);
    final entities = await db.tagDao.getAllTags();
    return entities.map((t) => t.toDomain()).toList();
  }

  Future<void> add(int expenseId, List<tag_domain.Tag> tagIds) async {
    final db = await ref.read(dbProvider.future);
    for (tag_domain.Tag i in tagIds) {
      var newJoin = ExpenseTagJoinEntity(expenseId: expenseId, tagId: i.id!);
      await db.expenseTagDao.add(newJoin);
    }
  }
}
