import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/features/authentication/screens/login/widgets/login_form.dart';
import 'package:taskify/features/authentication/screens/login/widgets/login_header.dart';
import 'package:taskify/provider.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.read(navigationProvider).changeSelectedScreenIndex(0);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AColors.linearGradient2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// Login Heading (Logo, Title, SubTitle)
              LoginHeading(),

              SizedBox(height: ASizes.spaceBtwSections),

              LoginForm(
                emailController: emailController,
                passwordController: passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
