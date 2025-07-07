import 'package:expenso/entities/mapper/tag_mapper.dart';
import 'package:expenso/entities/tag.dart';
import 'package:expenso/providers/db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:expenso/domain/tag.dart' as tag_domain;

part '../generated/providers/tag_provider.g.dart';

@riverpod
class Tag extends _$Tag {
  @override
  Future<List<tag_domain.Tag>> build() async {
    final db = await ref.read(dbProvider.future);
    final entities = await db.tagDao.getAllTags();
    return entities.map((t) => t.toDomain()).toList();
  }

  Future<void> add(String name) async {
    final db = await ref.read(dbProvider.future);
    final id = await db.tagDao.insertTag(TagEntity(name: name));
    state = state.whenData(
      (l) => [...l, tag_domain.Tag(name: name, id: id, selected: true)],
    );
    return;
  }

  Future<void> select(int ind, bool val) async {
    state = state.whenData((list) {
      final updatedList = List.of(list);
      final item = updatedList[ind];
      updatedList[ind] = item.copyWith(selected: val);
      return updatedList;
    });
  }
}
