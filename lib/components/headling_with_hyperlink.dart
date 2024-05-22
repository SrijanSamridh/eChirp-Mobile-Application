import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class HeadlineWithHyperLink extends StatelessWidget {
  const HeadlineWithHyperLink({
    super.key,
    required this.headingText,
    required this.onPressed,
  });

  final String headingText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 1.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headingText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "see all",
              style: TextStyle(
                color: GlobalVariables.colors.primary,
                decoration: TextDecoration.underline,
                decorationColor: GlobalVariables.colors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
