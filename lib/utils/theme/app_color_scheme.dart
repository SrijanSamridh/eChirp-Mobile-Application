import 'package:flutter/material.dart';

abstract class AppColorScheme {
  Color get primary;
  Color get secondary;
  Color get chatBubble;
  Color get unselectedNavBar;
  Color get selectedNavBar;
  Color get background;
  Color get inputFieldBackground;
  Color get inputFieldCursor;
  Color get inputFieldSuffixIcon;
  Color get inputFieldFillColor;
  Color get inputFieldHint;
  Color get inputFieldFocusedBorder;
  Color get inputFieldEnabledBorder;
  Color get messageText;
  Color get messageBackground;
  LinearGradient get primaryGradient;
  LinearGradient get unselectedCardGradient;
}