// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:echirp/API/provider/user_provider.dart';
import 'package:echirp/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../API/models/user.models.dart';
import '../../../API/services/api_client.dart';

class EditProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>(); // Create a form key
  final _firstNameController =
      TextEditingController(); // Text editing controllers
  final _lastNameController = TextEditingController();
  final _bioController = TextEditingController();
  final _emailController = TextEditingController();

  // Update profile details
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with profile update
      final firstName = _firstNameController.text;
      final lastName = _lastNameController.text;
      final bio = _bioController.text;
      final email = _emailController.text;

      var body = {
        "providerId": email,
        "firstName": firstName,
        "lastName": lastName,
        "bio": bio
      };

      // Get Token
      String token = await ApiClient().getToken();

      // Header Configuration
      var headers = <String, String>{
        'Content-Type': 'application/json',
        'x-auth-token': token,
      };

      var uri = Uri.parse("$baseUrl/auth/"); // Assuming your API endpoint
      var response =
          await http.put(uri, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', "$firstName $lastName");
        Navigator.pushNamedAndRemoveUntil(
            context, ProfileScreen.routeName, (route) => false);
        // Handle successful update (e.g., navigate back to profile screen)
      } else {
        // Error handling
        String error =
            'Failed to update profile (code: ${response.statusCode})';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error)));
      }
    } else {
      // Form is invalid, show error messages
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fix the errors in your profile details.')),
      );
    }
  }

  final UserProvider _userProvider = UserProvider();

  @override
  void initState() {
    super.initState();
    _initProfileData();
  }

  Future<void> _initProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('_id').toString();
    await _userProvider.fetchUserData(id, true);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User? userData = _userProvider.userData;
    // ignore: avoid_print
    print(userData?.user?.firstName);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: userData?.user?.firstName,
                controller: _firstNameController, // Assign controller
                decoration: const InputDecoration(
                  labelText: 'First Name',
                  hintText: 'Enter your first name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: userData?.user?.lastName,
                controller: _lastNameController, // Assign controller
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                  hintText: 'Enter your last name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: userData?.user?.bio,
                controller: _bioController, // Assign controller
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  hintText: 'Tell us a bit about yourself',
                ),
                maxLines: 3, // Allow multiline input for bio
                validator: (value) {
                  // Optional: You can add validation for bio length or content
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                initialValue: userData?.user?.providerId,
                controller: _emailController, // Assign controller
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email address',
                ),
                keyboardType:
                    TextInputType.emailAddress, // Set keyboard type for email
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address.';
                  }
                  // Basic email validation (can be improved)
                  if (!value.contains('@')) {
                    return 'Please enter a valid email address.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
