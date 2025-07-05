import 'package:expenso/entities/tag.dart';
import 'package:floor/floor.dart';

@dao
abstract class TagDao {
  @Query("SELECT * from tag")
  Future<List<TagEntity>> getAllTags();

  @insert
  Future<int> insertTag(TagEntity t);
}
