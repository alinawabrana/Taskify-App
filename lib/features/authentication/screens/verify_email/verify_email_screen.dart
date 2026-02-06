import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/text_strings.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AColors.linearGradient2),
        child: Column(
          children: [
            AppBar(iconTheme: IconThemeData(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage(AImages.lightAppLogo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Text(
                    ATexts.confirmEmail,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Text(
                    ATexts.confirmEmailSubTitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: ASizes.spaceBtwSections * 3),

                  SizedBox(
                    width: AHelperFunctions.screenWidth(context),
                    child: ElevatedButton(
                      onPressed: () => GoRouter.of(context).push('/success'),
                      child: Text(ATexts.tContinue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
