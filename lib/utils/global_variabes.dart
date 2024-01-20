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
  static const LinearGradient _unselectedCardGradient =
      LinearGradient(colors: [Colors.white, Colors.white]);
}

class GlobalVariables {
  static const Color kPrimaryColor = ColorSchema._primary;
  static const Color kSecondaryColor = ColorSchema._secondary;
  static const backgroundColor = Colors.white;
  static var selectedNavBarColor = Colors.orange[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const LinearGradient kPrimaryGradientColor =
      ColorSchema._primaryGradient;
  static const LinearGradient kUnselectedCardGradientColor =
      ColorSchema._unselectedCardGradient;
}
