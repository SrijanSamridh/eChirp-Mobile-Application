import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../utils/global_variabes.dart';

class GroupFormScreen extends StatelessWidget {
  static const String routeName = '/group-form';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.text_fields_outlined,
                  color: GlobalVariables.kPrimaryColor,
                  size: 30,
                ),
                SizedBox(width: 6),
                Text(
                  'Group Title',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildTextFieldWithBorder(size.height * 0.05, "Title..."),
            SizedBox(height: 20.0),
            Row(
              children: [
                Icon(
                  Icons.description,
                  color: GlobalVariables.kPrimaryColor,
                  size: 30,
                ),
                SizedBox(width: 6),
                Text(
                  'Group Description',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildTextFieldWithBorder(
                size.height * 0.16, 'Group is all about...'),
            SizedBox(height: 20.0),
            Row(
              children: [
                Icon(
                  Icons.image,
                  color: GlobalVariables.kPrimaryColor,
                  size: 30,
                ),
                SizedBox(width: 6),
                Text(
                  'Cover Image',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            _buildCoverImageContainer(),
            SizedBox(height: size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Handle back button press
                  },
                  child: Text('Back', style: TextStyle(fontSize: 20, color: Colors.grey[700]),),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: GlobalVariables.kPrimaryGradientColor,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Handle create group button press
                    },
                    child: Text('Create Group',style: TextStyle(fontSize: 16, color: Colors.white,),
                  ),
                ),),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithBorder(double height, String hintText) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: GlobalVariables.kPrimaryColor),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget _buildCoverImageContainer() {
    return DottedBorder(
      color: GlobalVariables.kPrimaryColor,
      radius: Radius.circular(20),
      borderType: BorderType.RRect,
      strokeWidth: 1,
      dashPattern: [8, 4],
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.ios_share_rounded,
              size: 40.0,
              color: GlobalVariables.kPrimaryColor,
            ),
            SizedBox(height: 10.0),
            Text(
              'Upload the cover image for the group',
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
