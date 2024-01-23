// ignore_for_file: use_build_context_synchronously

import 'package:echirp/components/bottom_bar.dart';
import 'package:echirp/components/custom_btn.dart';
import 'package:echirp/utils/global_variabes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../../components/custom_clipper.dart';

// ignore: must_be_immutable
class UploadStatusScreen extends StatefulWidget {
  static const String routeName = '/upload-status';
  const UploadStatusScreen({
    super.key,
    required this.eventType,
  });

  final String? eventType;

  @override
  State<UploadStatusScreen> createState() => _UploadState();
}

class _UploadState extends State<UploadStatusScreen> {
  String inviteCode = "cnedln-ejorj-fcdsln-er";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipPath(
            clipper: MyCustomClipper(),
            child: Container(
              height: size.height * 0.18,
              decoration: const BoxDecoration(
                gradient: GlobalVariables.kPrimaryGradientColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset('assets/animations/logo2.json',
                height: size.height * 0.2),
          ),
          SizedBox(
            height: size.height * 0.125,
            child: Expanded(
              child: Text(
                textAlign: TextAlign.center,
                'Congratulations!\n'
                'Your ${widget.eventType?.split('.')[1] == "private" ? "private" : ""} event has been created \nsuccessfully.',
                style: TextStyle(fontSize: size.height * 0.02),
              ),
            ),
          ),
          widget.eventType?.split('.')[1] == "public"
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBtn(
                      text: "Invite People",
                      size: size,
                      onPressed: () {},
                      width: size.width * 0.08,
                    ),
                    OutlinedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: GlobalVariables.kPrimaryColor)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              BottomBar.routeName,
                              arguments: 0,
                              (route) => false);
                        },
                        child: SizedBox(
                            height: size.height * 0.06,
                            width: size.width * 0.3,
                            child: const Center(child: Text('Close'))))
                  ],
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.2,
                  ),
                  decoration: BoxDecoration(
                    color: GlobalVariables.kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(inviteCode),
                ),
          widget.eventType?.split('.')[1] == "private"? CustomBtn(
            text: "Copy Code",
            size: size,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: inviteCode));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to Clipboard')),
              );
              Navigator.of(context).pushNamedAndRemoveUntil(
                  BottomBar.routeName, arguments: 1, (route) => false);
            },
            width: size.width * 0.08,
          ): Container(),
          Text(widget.eventType?.split('.')[1] == "private" ?'Copy your private event code': ''),
          SizedBox(
            height: size.height * 0.1,
          )
        ],
      ),
    );
  }
}
