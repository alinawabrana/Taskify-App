import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/common/widgets/images/circular_image_container.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../common/widgets/text_form_field/primary_text_form_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.currentUser});

  final Map<String, dynamic> currentUser;

  @override
  State<Profile> createState() => _EditProfileState();
}

class _EditProfileState extends State<Profile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.currentUser['firstName'];
    lastNameController.text = widget.currentUser['lastName'];
    userNameController.text = widget.currentUser['username'];
    emailController.text = widget.currentUser['email'];
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          AppBar(
            backgroundColor: AColors.primaryColor,
            iconTheme: IconThemeData(color: Colors.white),
            title: Row(
              children: [
                Text(
                  'Edit Profile',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Iconsax.edit,
                  size: 20,
                  color: Colors.white.withOpacity(0.5),
                ),
              ],
            ),
          ),

          SizedBox(height: ASizes.spaceBtwItems),

          Stack(
            children: [
              CircularImageContainer(
                imageUrl: widget.currentUser['imageUrl'],
                width: 200,
                height: 200,
              ),
              Positioned(
                bottom: 30,
                left: 150,
                child: IconButton(
                  onPressed: () {},
                  color: Colors.blueAccent,
                  icon: Icon(Iconsax.edit_2),
                ),
              ),
            ],
          ),

          SizedBox(height: ASizes.spaceBtwSections / 2),
          Center(
            child: SizedBox(
              width: AHelperFunctions.screenWidth(context) * 0.9,
              height: AHelperFunctions.screenHeight(context) * 0.4,
              child: Card(
                color: AColors.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(ASizes.defaultSpace),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: PrimaryTextFormField(
                              label: 'First Name',
                              controller: firstNameController,
                            ),
                          ),
                          SizedBox(width: ASizes.spaceBtwItems),
                          Flexible(
                            child: PrimaryTextFormField(
                              label: 'Last Name',
                              controller: lastNameController,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: ASizes.spaceBtwItems),
                      PrimaryTextFormField(
                        label: 'UserName',
                        controller: userNameController,
                      ),
                      SizedBox(height: ASizes.spaceBtwItems),
                      PrimaryTextFormField(
                        label: 'Email',
                        controller: emailController,
                        enabled: false,
                        fontColor: Colors.grey,
                      ),
                      Spacer(),
                      SizedBox(
                        width: AHelperFunctions.screenWidth(context),
                        child: ElevatedButton(
                          onPressed: () {
                            widget.currentUser['firstName'] =
                                firstNameController.text;
                            widget.currentUser['lastName'] =
                                lastNameController.text;
                            widget.currentUser['username'] =
                                userNameController.text;
                            GoRouter.of(context).pop();
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
