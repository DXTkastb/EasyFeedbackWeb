
import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final void Function(int numbers) reloadfunction;
  final int num;

  const CustomDropDown({Key? key, required this.reloadfunction, required this.num})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int selected = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selected = widget.num;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
        underline: null,
        icon: null,
        value: selected,
        items: <int>[
          5,
          10,
          20,
        ].map<DropdownMenuItem<int>>((int value) {
          return DropdownMenuItem<int>(
            value: value,
            child: Text("$value"),
          );
        }).toList(),
        onChanged: (int? newSelected) {
          setState(() {
            widget.reloadfunction(newSelected!);
            selected = newSelected!;
          });
        });
  }
}
