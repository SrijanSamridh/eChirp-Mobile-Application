import 'package:flutter/material.dart';

import '../screens/search/search.dart';
import '../utils/global_variabes.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.searchFor,
    required this.backgroundColor,
    required this.fillColor,
    required this.iconColor,
    this.iconSize,
    this.textSize, this.textColor,
  });

  final String searchFor;
  final Color backgroundColor;
  final Color fillColor;
  final Color iconColor;
  final double? iconSize;
  final double? textSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(18),
      elevation: 1,
      child: TextFormField(
        onFieldSubmitted: (value) => {
          Navigator.pushNamed(context, SearchScreen.routeName, arguments: value)
        },
        style: TextStyle(
          color: textColor ?? Colors.white,
        ),
        cursorColor: GlobalVariables.colors.primary,
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(
              Icons.search,
              color: iconColor,
              size: iconSize ?? 23,
            ),
          ),
          filled: true,
          fillColor: fillColor,
          contentPadding: const EdgeInsets.only(top: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(
              color: GlobalVariables.colors.primary,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Colors.transparent,
              width: 0,
            ),
          ),
          hintText: 'Search for ${searchFor.toLowerCase()}',
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 158, 158, 158),
            fontSize: textSize ?? 17,
          ),
        ),
      ),
    );
  }
}
