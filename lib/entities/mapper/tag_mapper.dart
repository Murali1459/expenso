import 'package:expenso/domain/tag.dart';
import 'package:expenso/entities/tag.dart';

extension TagEntityMapper on TagEntity {
  Tag toDomain() => Tag(id: id, name: name);
}

extension TagDomainMapper on Tag {
  TagEntity toEntity() => TagEntity(id: id, name: name);
}
