import 'package:flutter/material.dart';
import 'package:taskify/common/widgets/text_form_field/primary_text_form_field.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.currentUser});

  final Map<String, dynamic> currentUser;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Change Password', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SizedBox(
          width: AHelperFunctions.screenWidth(context) * 0.9,
          height: AHelperFunctions.screenHeight(context) * 0.4,
          child: Card(
            color: AColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  PrimaryTextFormField(
                    label: 'Old Password',
                    controller: oldPassword,
                  ),
                  Divider(),
                  SizedBox(height: ASizes.spaceBtwItems),
                  PrimaryTextFormField(
                    label: 'New Password',
                    controller: newPassword,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  PrimaryTextFormField(
                    label: 'Re-Write Password',
                    controller: confirmPassword,
                  ),
                  Spacer(),
                  SizedBox(
                    width: AHelperFunctions.screenWidth(context),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Change'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
