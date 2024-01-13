import 'package:flutter/material.dart';

import '../utils/constents.dart';


class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onPressed,
    required this.searchFor,
  });

  final VoidCallback onPressed;
  final String searchFor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(64, 255, 255, 255),
      borderRadius: BorderRadius.circular(18),
      elevation: 1,
      child: TextFormField(
        onFieldSubmitted: (value) => {onPressed},
        style: const TextStyle(color: Colors.white),
        cursorColor: GlobalVariables.kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 6),
            child: Icon(
              Icons.search,
              color: Color.fromARGB(255, 239, 239, 239),
              size: 23,
            ),
          ),
          filled: true,
          fillColor: const Color.fromARGB(90, 50, 50, 50),
          contentPadding: const EdgeInsets.only(top: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: GlobalVariables.kPrimaryColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              width: 1,
            ),
          ),
          hintText: 'Search for ${searchFor.toLowerCase()}',
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 158, 158, 158),
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
