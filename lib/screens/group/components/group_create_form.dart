import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:echirp/components/bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../../API/controller/group.controller.dart';
import '../../../utils/utils.dart';

class GroupFormScreen extends StatefulWidget {
  static const String routeName = '/group-form';

  const GroupFormScreen({
    Key? key,
    this.category,
    this.subCategory,
    this.subSubCategory,
  }) : super(key: key);

  final String? category;
  final String? subCategory;
  final String? subSubCategory;

  @override
  GroupFormScreenState createState() => GroupFormScreenState();
}

class GroupFormScreenState extends State<GroupFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? image;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> selectImage() async {
    var res = await pickImages();
    if (res.isNotEmpty) {
      setState(() {
        image = res.first;
      });
    }
  }

  void _handleSubmitButton() async {
    if (_formKey.currentState!.validate()) {
      // Define the request body
      Map<String, dynamic> requestBody = {
        "name": _titleController.text,
        "description": _descriptionController.text,
        "imageUrl": image?.path,
        "category": widget.category,
        "subCategory": widget.subCategory,
        "subSubCategory": widget.subSubCategory
      };

      var response = await GroupController().createGroup(requestBody);
      if (response != null) {
        // Show SnackBar with the response message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response["message"]),
          ),
        );
        Navigator.pushNamedAndRemoveUntil(
            // ignore: use_build_context_synchronously
            context, BottomBar.routeName, arguments: 3, (route) => false);
      } else {
        // Group creation failed
        // Handle error
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Group creation failed.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Group Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildLabelWithIcon(Icons.text_fields_outlined, 'Group Title'),
              const SizedBox(height: 10.0),
              buildTextFieldWithBorder(
                "Title...",
                _titleController,
              ),
              const SizedBox(height: 20.0),
              buildLabelWithIcon(Icons.description, 'Group Description'),
              const SizedBox(height: 10.0),
              buildTextFieldWithBorder(
                "Group is all about...",
                _descriptionController,
                maxLines: 6,
              ),
              const SizedBox(height: 20.0),
              buildLabelWithIcon(Icons.image, 'Cover Image'),
              const SizedBox(height: 10.0),
              buildCoverImageContainer(),
              const SizedBox(height: 20.0),
              buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabelWithIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.orange,
          size: 30,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget buildTextFieldWithBorder(
    String hintText,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }

  Widget buildCoverImageContainer() {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: selectImage,
      child: image == null
          ? DottedBorder(
              color: Colors.orange,
              radius: const Radius.circular(20),
              borderType: BorderType.RRect,
              strokeWidth: 1,
              dashPattern: const [8, 4],
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.ios_share_rounded,
                      size: 40.0,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      'Upload the cover image for the group',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ))
          : Container(
              height: size.width * 0.3,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            // Handle back button press
          },
          child: Text(
            'Back',
            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.orange, Colors.orangeAccent],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextButton(
            onPressed: _handleSubmitButton,
            child: const Text(
              'Create Group',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
