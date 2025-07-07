import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final bool selected;
  final String label;
  final void Function(bool) onSelect;
  const CustomChip({
    super.key,
    required this.selected,
    required this.label,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: StadiumBorder(),
      onTap: () => onSelect(!selected),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(color: Colors.white)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) Icon(CupertinoIcons.checkmark, size: 18),
            Text(label),
          ],
        ),
      ),
    );
  }
}
