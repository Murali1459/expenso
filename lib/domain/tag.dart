import 'package:freezed_annotation/freezed_annotation.dart';

part '../generated/domain/tag.freezed.dart';
part '../generated/domain/tag.g.dart';

@freezed
class Tag with _$Tag {
  factory Tag({
    int? id,
    @Default('') String name,
    @Default(false) bool selected,
  }) = _Tag;

  factory Tag.fromJson(Map<String, Object?> json) => _$TagFromJson(json);
}
