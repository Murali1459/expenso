import 'package:floor/floor.dart';

@Entity(tableName: "tag")
class TagEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  @ColumnInfo(name: "name")
  final String name;

  TagEntity({this.id, required this.name});
}
