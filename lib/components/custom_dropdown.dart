import 'package:flutter/material.dart';

import '../utils/global_variabes.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.dropdownValue,
      required this.size,
      required this.onChnaged,
      required this.categorys});

  final String dropdownValue;
  final List<String> categorys;
  final Size size;
  final Function(String?) onChnaged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.arrow_drop_down_circle,
          color: GlobalVariables.kPrimaryColor,
        ),
      ),
      elevation: 16,
      style: const TextStyle(
          color: Color.fromARGB(255, 87, 47, 14), fontSize: 14.0),
      underline: Container(
        height: 2,
        color: GlobalVariables.kPrimaryColor,
        width: size.width * 0.2,
      ),
      onChanged: onChnaged,
      items: categorys.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
