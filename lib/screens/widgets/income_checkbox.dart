import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomeCheckbox extends StatefulWidget {
  const IncomeCheckbox({super.key});

  @override
  State<IncomeCheckbox> createState() => _IncomeCheckboxState();
}

class _IncomeCheckboxState extends State<IncomeCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        SizedBox(
          width: 24,
          child: Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: _markAsIncome,
            onChanged: (a) => setState(() {
              _markAsIncome = a!;
            }),
          ),
        ),
        Text("Mark as income"),
      ],
    );
  }
}
