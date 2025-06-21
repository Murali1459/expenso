import 'package:expenso/entities/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TagChips extends StatefulWidget {
  final List<TagEntity> tags;
  const TagChips({super.key, required this.tags});

  @override
  State<TagChips> createState() => _TagChipsState();
}

class _TagChipsState extends State<TagChips> {
  List<TagEntity> selectedTags = [];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        for (TagEntity t in widget.tags) ...[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3),
            child: FilterChip(
              selected: selectedTags.contains(t),
              labelStyle: TextStyle(color: Colors.white),
              label: Text(t.name),
              onSelected: (val) {
                setState(() {
                  if (val) {
                    selectedTags = [...selectedTags, t];
                    return;
                  }
                  selectedTags.remove(t);
                });
              },
            ),
          ),
        ],
        IconButton.outlined(onPressed: () {}, icon: Icon(CupertinoIcons.add)),
      ],
    );
  }
}
