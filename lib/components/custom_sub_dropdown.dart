import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class CustomSubDropdown extends StatelessWidget {
  final String dropdownValue;
  final Size size;
  final ValueChanged<String?>? onChanged;
  final Map<String, List<String>> categorySubcategories;

  const CustomSubDropdown({super.key, 
    required this.dropdownValue,
    required this.size,
    required this.onChanged,
    required this.categorySubcategories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width *0.1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: GlobalVariables.colors.primary,
          width: 2,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon:  Icon(Icons.arrow_drop_down_circle, color: GlobalVariables.colors.primary),
        iconSize: 24,
        elevation: 16,
        borderRadius: BorderRadius.circular(10),
        style:  TextStyle(color: GlobalVariables.colors.primary),
        onChanged: onChanged,
        items: categorySubcategories.keys
            .map<DropdownMenuItem<String>>(
              (String category) => DropdownMenuItem<String>(
                value: category,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(category),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
