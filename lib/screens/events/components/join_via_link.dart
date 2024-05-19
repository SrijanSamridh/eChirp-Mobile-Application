// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:echirp/API/controller/event.controller.dart';
import '../../../components/custom_btn.dart';
import '../../../utils/global_variabes.dart';
import 'upload_status.dart';

class JoinViaLink extends StatelessWidget {
  final Size size;
  final TextEditingController _codeController = TextEditingController();
  final EventController eventController;

  JoinViaLink({
    Key? key,
    required this.size,
    required this.eventController,
  }) : super(key: key);

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Do something when 'OK' is pressed
          },
        ),
      ),
    );
  }

  Future<void> _joinEvent(BuildContext context) async {
    try {
      var response = await eventController.postEvent(context ,_codeController.text);
      if (response != null) {
        debugPrint('Response from server: $response');
      }
      Navigator.pushNamed(context, UploadStatusScreen.routeName, arguments: "public");
    } catch (e) {
      debugPrint("Error joining event: $e");
      showToast(context, "Failed to join event. Please try again later.");
    }
  }
  
  // @override
  // void dispose() {
  //   _codeController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            Image.asset(
              'assets/images/Groupjoinvialink.png',
            ),
            const Text(
              "Want to join?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: size.width*0.1),
              child: Text(
                textAlign: TextAlign.center,
                "Please enter the event link code you received to gain access and join the event.",
                style: TextStyle(fontSize: size.height * 0.014),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(18),
                elevation: 1,
                child: TextFormField(
                  controller: _codeController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: GlobalVariables.colors.primary,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: size.width * 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: GlobalVariables.colors.primary,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: GlobalVariables.colors.primary.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    hintText: ' Paste or enter the event link',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 158, 158, 158),
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.06),
            CustomBtn(
              text: 'Join',
              size: size,
              onPressed: () => _joinEvent(context),
              height: size.height * 0.01,
              width: size.width * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}