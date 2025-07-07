import 'package:expenso/providers/tag_provider.dart';
import 'package:expenso/screens/widgets/save_discard_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddTag extends ConsumerStatefulWidget {
  const AddTag({super.key});

  @override
  ConsumerState<AddTag> createState() => _AddTagState();
}

class _AddTagState extends ConsumerState<AddTag> {
  late TextEditingController _newTagCtr;

  @override
  void initState() {
    super.initState();
    _newTagCtr = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newTagCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add new Tag"),
      content: TextField(
        controller: _newTagCtr,
        onChanged: (_) => setState(() {}),
      ),
      actions: [
        SaveDiscardButtons(
          onSave: () async {
            await ref.read(tagProvider.notifier).add(_newTagCtr.text);
          },
          saveEnabled: _newTagCtr.text.length > 3,
        ),
      ],
    );
  }
}
