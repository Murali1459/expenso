import 'package:flutter/material.dart';

class SaveDiscardButtons extends StatelessWidget {
  final void Function() onSave;
  final bool saveEnabled;

  const SaveDiscardButtons({
    super.key,
    required this.onSave,
    this.saveEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      spacing: 8,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text("Discard"),
        ),
        TextButton(
          onPressed: () {
            if (!saveEnabled) return;
            onSave();
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Save",
            style: TextStyle(color: !saveEnabled ? Colors.grey : null),
          ),
        ),
      ],
    );
  }
}
