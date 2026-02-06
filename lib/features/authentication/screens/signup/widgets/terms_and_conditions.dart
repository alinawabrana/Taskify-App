import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: 20,
              child: Checkbox(
                value: false,
                onChanged: (value) {},
                activeColor: Colors.blue,
                side: BorderSide(color: Colors.white),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ATexts.iAgreeTo,
                    style: TextStyle(
                      fontSize: ASizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: ' '),
                  TextSpan(
                    text: ATexts.privacyPolicy,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white30,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(text: ' & '),
                  TextSpan(
                    text: ATexts.termsOfUse,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: Colors.white30,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: ASizes.spaceBtwItems),

        Row(
          children: [
            SizedBox(
              width: 30,
              height: 20,
              child: Checkbox(
                value: true,
                onChanged: (value) {},
                activeColor: Colors.blue,
                side: BorderSide(color: Colors.white),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: ATexts.emailMarketing,
                    style: TextStyle(
                      fontSize: ASizes.fontSizeMd,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
