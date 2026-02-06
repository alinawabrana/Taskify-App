import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:taskify/features/authentication/screens/signup/widgets/terms_and_conditions.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/constants/text_strings.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../common/widgets/login_signup/text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AColors.linearGradient2),
        child: Column(
          children: [
            /// back Button and Headline
            AppBar(iconTheme: IconThemeData(color: Colors.white)),

            Text(
              ATexts.signupTitle,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: ASizes.spaceBtwSections),

            /// Sign up Form
            Card(
              color: Colors.white.withOpacity(0.08),
              child: SizedBox(
                width: AHelperFunctions.screenWidth(context) * 0.9,
                height: AHelperFunctions.screenHeight(context) * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(ASizes.defaultSpace / 2),
                  child: Column(
                    children: [
                      SignupForm(
                        firstNameController: firstNameController,
                        lastNameController: lastNameController,
                        emailController: emailController,
                        phoneNumberController: phoneNumberController,
                        passwordController: passwordController,
                        verifyPasswordController: verifyPasswordController,
                      ),

                      SizedBox(height: ASizes.spaceBtwSections),

                      TermsAndCondition(),

                      SizedBox(height: ASizes.spaceBtwSections),

                      SizedBox(
                        width: AHelperFunctions.screenWidth(context),
                        child: ElevatedButton(
                          onPressed:
                              () => GoRouter.of(context).push('/verify-email'),
                          child: Text(ATexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
