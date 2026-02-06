import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/common/widgets/login_signup/text_form_field.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_function.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white.withOpacity(0.08),
        elevation: 5,
        child: SizedBox(
          width: AHelperFunctions.screenWidth(context) * 0.9,
          height: AHelperFunctions.screenHeight(context) * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace / 2),
            child: Column(
              children: [
                Text(
                  'LOGIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.white,
                  ),
                ),
                SizedBox(height: ASizes.spaceBtwItems),

                /// INPUT FIELDS
                LoginSignupTextFormField(
                  controller: emailController,
                  labelText: ATexts.email,
                ),
                SizedBox(height: ASizes.spaceBtwItems),
                LoginSignupTextFormField(
                  controller: passwordController,
                  labelText: ATexts.password,
                ),
                SizedBox(height: ASizes.spaceBtwItems),

                /// Remember me & Forget password
                Row(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Checkbox(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.blue,
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        Text(
                          ATexts.rememberMe,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        ATexts.forgetPassword,
                        style: TextStyle(color: Colors.blueGrey, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ASizes.spaceBtwItems),

                SizedBox(height: ASizes.spaceBtwSections),

                /// Login Button
                SizedBox(
                  width: AHelperFunctions.screenWidth(context),
                  child: ElevatedButton(
                    onPressed: () => GoRouter.of(context).go('/navigation'),
                    child: Text('Login'),
                  ),
                ),

                SizedBox(height: ASizes.spaceBtwItems),
                SizedBox(
                  width: AHelperFunctions.screenWidth(context),
                  child: OutlinedButton(
                    onPressed: () => GoRouter.of(context).push('/signup'),
                    child: Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
