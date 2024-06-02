import 'package:flutter/material.dart';

import '../../../utils/global_variables.dart';

class TripleProfilePic extends StatelessWidget {
  const TripleProfilePic({
    super.key,
    required this.size, required this.path1, required this.path2, required this.path3,
  });
  final String path1;
  final String path2;
  final String path3;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: 26.0,
          width: 26.0,
          margin: EdgeInsets.only(left: size.width * 0.18),
          decoration: BoxDecoration(
              gradient:
              GlobalVariables.colors.primaryGradient,
              borderRadius: const BorderRadius.all(
                  Radius.circular(50.0)),
              border: Border.all(
                  color: GlobalVariables.colors.primary)),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(50.0)),
            child: Image.asset(
              path1,
              height: 25.0,
            ),
          ),
        ),
        Container(
          height: 26.0,
          width: 26.0,
          margin: EdgeInsets.only(left: size.width * 0.1),
          decoration: BoxDecoration(
              gradient:
              GlobalVariables.colors.primaryGradient,
              borderRadius: const BorderRadius.all(
                  Radius.circular(50.0)),
              border: Border.all(
                  color: GlobalVariables.colors.primary)),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(50.0)),
            child: Image.asset(
              path2,
              height: 25.0,
            ),
          ),
        ),
        Container(
          height: 26.0,
          width: 26.0,
          margin: EdgeInsets.only(left: size.width * 0.02),
          decoration: BoxDecoration(
              gradient:
              GlobalVariables.colors.primaryGradient,
              borderRadius: const BorderRadius.all(
                  Radius.circular(50.0)),
              border: Border.all(
                  color: GlobalVariables.colors.primary)),
          child: ClipRRect(
            borderRadius:
            const BorderRadius.all(Radius.circular(50.0)),
            child: Image.asset(
              path3,
              height: 25.0,
            ),
          ),
        ),
      ],
    );
  }
}