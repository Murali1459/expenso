import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/screen_provider.g.dart';

@riverpod
class Screen extends _$Screen {
  @override
  int build() => 0;

  void change(int val) => state = val;
}
