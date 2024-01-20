import 'package:flutter/material.dart';

import '../../../components/custom_btn.dart';
import '../../../utils/global_variabes.dart';

class JoinViaLink extends StatelessWidget {
  const JoinViaLink({
    super.key,
    required this.size, required this.onPressed,
  });

  final Size size;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.02),
            const Image(
              image: AssetImage('assets/images/Groupjoinvialink.png'),
            ),
            const Text(
              "Join via Link",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.02),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                "Lorem ipsum dolor sit amet, conct adipiscing elit. Lorem ipsum dolor sit amet, conct adipiscing elit.Lorem ipsum dolor sit amet, conct adipiscing elit.Lorem ipsum dolor sit amet, conct adipiscing.",
                style: TextStyle(fontSize: size.height * 0.012),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                borderRadius: BorderRadius.circular(18),
                elevation: 1,
                child: TextFormField(
                  onFieldSubmitted: (value) => {onPressed},
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  cursorColor: GlobalVariables.kPrimaryColor,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: size.width * 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(
                        color: GlobalVariables.kPrimaryColor,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: GlobalVariables.kPrimaryColor.withOpacity(0.5),
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
              onPressed: onPressed,
              height: size.height * 0.01,
              width: size.width * 0.08,
            ),
          ],
        ),
      ),
    );
  }
}