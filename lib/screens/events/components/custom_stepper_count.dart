import 'package:dotted_border/dotted_border.dart';
import 'package:echirp/utils/global_variables.dart';
import 'package:flutter/material.dart';

class CustomStepperCount extends StatelessWidget {
   CustomStepperCount({
    super.key,
    required this.currentIndex,
    required this.size,
  });

  final int currentIndex;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            currentIndex >= 1
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.015,
                        horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                      gradient: GlobalVariables.colors.primaryGradient,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:  const Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                : DottedBorder(
                    borderType: BorderType.RRect,
                    radius:  const Radius.circular(50),
                    dashPattern:  [10, 10],
                    color: GlobalVariables.colors.primary,
                    strokeWidth: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.013,
                        horizontal: size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        '1',
                        style: TextStyle(
                            color: GlobalVariables.colors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            currentIndex >= 2
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.015,
                        horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                      gradient: GlobalVariables.colors.primaryGradient,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:  const Text(
                      '2',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                : DottedBorder(
                    borderType: BorderType.RRect,
                    radius:  const Radius.circular(50),
                    dashPattern:  [10, 10],
                    color: GlobalVariables.colors.primary,
                    strokeWidth: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.013,
                        horizontal: size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        '2',
                        style: TextStyle(
                            color: GlobalVariables.colors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
            currentIndex >= 3
                ? Container(
                    padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.015,
                        horizontal: size.width * 0.05),
                    decoration: BoxDecoration(
                      gradient: GlobalVariables.colors.primaryGradient,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:  const Text(
                      '3',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                : DottedBorder(
                    borderType: BorderType.RRect,
                    radius:  const Radius.circular(50),
                    dashPattern:  [10, 10],
                    color: GlobalVariables.colors.primary,
                    strokeWidth: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.013,
                        horizontal: size.width * 0.04,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child:  Text(
                        '3',
                        style: TextStyle(
                            color: GlobalVariables.colors.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
          ],
        ),
        SizedBox(height: size.height * 0.01),
        if (currentIndex == 1)
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Event Information',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          )
        else if (currentIndex == 2)
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Event Specifications',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          )
        else if (currentIndex == 3)
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Upload',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          )
        else
           const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(''),
          ),
      ],
    );
  }
}
