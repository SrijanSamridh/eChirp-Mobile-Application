import 'package:flutter/material.dart';

class ColorSchema {
  static const Color _primary = Color.fromARGB(255, 236, 135, 53);
  static const Color _secondary = Colors.white;
  static const LinearGradient _primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(255, 169, 99, 1),
      Color.fromRGBO(238, 143, 143, 1),
    ],
  );
}

class GlobalVariables {
  static const Color kPrimaryColor = ColorSchema._primary;
  static const Color kSecondaryColor = ColorSchema._secondary;
  static const LinearGradient kPrimaryGradientColor =
      ColorSchema._primaryGradient;
}
