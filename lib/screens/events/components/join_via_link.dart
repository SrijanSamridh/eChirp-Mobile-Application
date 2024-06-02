import 'dart:convert';

import 'package:echirp/API/services/Manager/dialog_manager.dart';
import 'package:echirp/screens/events/components/join_via_link_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:echirp/API/controller/event.controller.dart';
import '../../../API/services/helper/api_error.dart';
import '../../../components/custom_btn.dart';
import '../../../utils/global_variables.dart';
import 'upload_status.dart';

class JoinViaLink extends StatefulWidget {
  final Size size;
  final EventController eventController;

  const JoinViaLink({
    Key? key,
    required this.size,
    required this.eventController,
  }) : super(key: key);

  @override
  _JoinViaLinkState createState() => _JoinViaLinkState();
}

class _JoinViaLinkState extends State<JoinViaLink> {
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() async {
    if (_focusNode.hasFocus) {
      ClipboardData? clipboardData = await Clipboard.getData('text/plain');
      if (clipboardData != null && clipboardData.text != null && clipboardData.text!.isNotEmpty) {
        setState(() {
          _codeController.text = clipboardData.text!;
        });
      }
    }
  }

  Future<void> _joinEvent(BuildContext context) async {
    try {
      var response = await widget.eventController.postEvent(context, _codeController.text);
      if (response != null) {
        debugPrint('Response from server: $response');
        Navigator.pushNamed(context, JoinViaLinkStatus.routeName, arguments: {
          'isSuccess': true,
          'eventCode': _codeController.text
        });
      }
    } catch (e) {
      String errorMessage = 'Something went wrong. Please try again later.';
      if (e is ApiError && e.details != null) {
        debugPrint('Error details: ${e.details}');

        // Extract error message using split
        if (e.details.contains('Details:')) {
          try {
            String details = e.details.split('Details:').last.trim();
            if (details.startsWith('{') && details.endsWith('}')) {
              final errorDetails = jsonDecode(details);
              errorMessage = errorDetails['message'] ?? errorMessage;
            } else {
              errorMessage = details;
            }
          } catch (parseError) {
            debugPrint("Error parsing error details: $parseError");
          }
        } else {
          errorMessage = e.details;
        }
      }
      debugPrint("Error joining event: $e");
      Navigator.pushNamed(context, JoinViaLinkStatus.routeName, arguments: {
        'isSuccess': false,
        'eventCode': _codeController.text,
        'errorMessage': errorMessage,
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: widget.size.height * 0.02),
            Image.asset(
              'assets/images/Groupjoinvialink.png',
            ),
            const Text(
              "Want to join?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: widget.size.height * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: widget.size.width * 0.1),
              child: Text(
                textAlign: TextAlign.center,
                "Please enter the event link code you received to gain access and join the event.",
                style: TextStyle(fontSize: widget.size.height * 0.014),
              ),
            ),
            SizedBox(height: widget.size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(18),
                elevation: 1,
                child: TextFormField(
                  controller: _codeController,
                  focusNode: _focusNode,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: GlobalVariables.colors.primary,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: widget.size.width * 0.05),
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
            SizedBox(height: widget.size.height * 0.06),
            CustomBtn(
              text: 'Join',
              size: widget.size,
              onPressed: () => _joinEvent(context),
              height: widget.size.height * 0.01,
              width: widget.size.width * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}
