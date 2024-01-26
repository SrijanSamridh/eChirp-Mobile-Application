import 'package:flutter/material.dart';

import '../utils/global_variabes.dart';

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
          color: GlobalVariables.kPrimaryColor,
          width: 2,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_circle, color: GlobalVariables.kPrimaryColor),
        iconSize: 24,
        elevation: 16,
        borderRadius: BorderRadius.circular(10),
        style: const TextStyle(color: GlobalVariables.kPrimaryColor),
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
