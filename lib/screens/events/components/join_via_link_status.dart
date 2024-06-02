import 'package:echirp/API/services/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../components/custom_btn.dart';
import '../../../components/custom_clipper.dart';
import '../../../utils/global_variables.dart';

class JoinViaLinkStatus extends StatelessWidget {
  static const String routeName = '/join-via-link-status';
  final bool isSuccess;
  final String? eventCode;
  final String? errorMessage;

  const JoinViaLinkStatus({Key? key, required this.isSuccess, this.eventCode, this.errorMessage})
      : super(key: key);

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
              decoration: BoxDecoration(
                gradient: isSuccess
                    ? GlobalVariables.colors.successGradient
                    : GlobalVariables.colors.errorGradient,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
              isSuccess
                  ? 'assets/animations/success_animation.json'
                  : 'assets/animations/error_animation.json',
              height: size.height * 0.2,
            ),
          ),
          SizedBox(
            height: size.height * 0.125,
            child: Text(
              isSuccess
                  ? 'Congratulations!\nYour\'ve joined the event successfully.'
                  : 'Oops!\n $errorMessage',
              style: TextStyle(fontSize: size.height * 0.02),
              textAlign: TextAlign.center,
            ),
          ),
          isSuccess
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomBtn(
                      text: "Share Now",
                      size: size,
                      onPressed: () {
                        Helper().share(context, eventCode.toString());
                      },
                      width: size.width * 0.08,
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        side: MaterialStateProperty.all(
                          BorderSide(color: GlobalVariables.colors.primary),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: SizedBox(
                        height: size.height * 0.06,
                        width: size.width * 0.3,
                        child: const Center(child: Text('Close')),
                      ),
                    ),
                  ],
                )
              : Container(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.2,
                  ),
                  decoration: BoxDecoration(
                    color: GlobalVariables.colors.error.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text('Failed to join event.'),
                ),
          isSuccess
              ? Container()
              : CustomBtn(
                  text: "Retry",
                  size: size,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  width: size.width * 0.08,
                ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
