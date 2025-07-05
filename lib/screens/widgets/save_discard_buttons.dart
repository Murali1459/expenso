import 'package:flutter/material.dart';

class SaveDiscardButtons extends StatelessWidget {
  final void Function() onSave;
  final void Function() onDiscard;
  final bool saveEnabled;

  const SaveDiscardButtons({
    super.key,
    required this.onSave,
    this.saveEnabled = true,
    required this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        TextButton(onPressed: onDiscard, child: Text("Discard")),
        TextButton(
          onPressed: onSave,
          child: Text(
            "Save",
            style: TextStyle(color: !saveEnabled ? Colors.grey : null),
          ),
        ),
      ],
    );
  }
}
