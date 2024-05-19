import 'package:flutter/material.dart';

import '../utils/global_variabes.dart';

// ignore: must_be_immutable
class CustomDropdown extends StatelessWidget {
  final dynamic dropdownValue;
  final Size size;
  final ValueChanged<String?>? onChanged;
  final List<String> categories;
  LinearGradient? backgroundColor; 

  CustomDropdown({super.key, 
    required this.dropdownValue,
    required this.size,
    required this.onChanged,
    required this.categories,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: backgroundColor ?? GlobalVariables.colors.primaryGradient,
        border: Border.all(
          color: GlobalVariables.colors.primary,
          width: 1,
        ),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        dropdownColor: GlobalVariables.colors.primary,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.white,),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        items: categories
            .map<DropdownMenuItem<String>>(
              (String value) => DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(value),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}


