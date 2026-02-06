import 'package:flutter/material.dart';

import '../../../../../common/widgets/login_signup/text_form_field.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.passwordController,
    required this.verifyPasswordController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController passwordController;
  final TextEditingController verifyPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: LoginSignupTextFormField(
                controller: firstNameController,
                labelText: ATexts.firstName,
              ),
            ),
            SizedBox(width: ASizes.spaceBtwItems),
            Flexible(
              child: LoginSignupTextFormField(
                controller: lastNameController,
                labelText: ATexts.lastName,
              ),
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        LoginSignupTextFormField(
          controller: emailController,
          labelText: ATexts.email,
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        LoginSignupTextFormField(
          controller: phoneNumberController,
          labelText: ATexts.phoneNo,
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        LoginSignupTextFormField(
          controller: passwordController,
          labelText: ATexts.password,
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye_outlined),
          ),
        ),
        SizedBox(height: ASizes.spaceBtwItems),
        LoginSignupTextFormField(
          controller: verifyPasswordController,
          labelText: 're-write Password',
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove_red_eye_outlined),
          ),
        ),
      ],
    );
  }
}
