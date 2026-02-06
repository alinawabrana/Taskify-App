import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/image_strings.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../utils/constants/text_strings.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AColors.linearGradient2),
        child: Column(
          children: [
            AppBar(iconTheme: IconThemeData(color: Colors.white)),
            Container(
              child: Lottie.asset(
                AImages.successAnimation,
                width: 300,
                height: 300,
                animate: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  Text(
                    'Congratulation!',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Text(
                    'Verification Complete',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwSections),
                  SizedBox(
                    width: AHelperFunctions.screenWidth(context),
                    child: ElevatedButton(
                      onPressed: () => GoRouter.of(context).push('/'),
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
