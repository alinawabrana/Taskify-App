import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/common/widgets/tiles/text_tile.dart';
import 'package:taskify/features/personlization/screens/setting/widgets/settings_tile.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../common/widgets/images/circular_image_container.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(settingProvider).user;
    final fullName = '${currentUser['firstName']} ${currentUser['lastName']}';
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {},
              child: CircularImageContainer(imageUrl: currentUser['imageUrl']),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  currentUser['email'],
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AColors.primaryColor,
        actions: [
          IconButton(
            color: Colors.white.withOpacity(0.5),
            onPressed: () {
              GoRouter.of(
                context,
              ).push('/setting', extra: {'currentUser': currentUser});
            },
            iconSize: 20,
            icon: Icon(Iconsax.edit),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace * 0.7),
            child: Column(
              children: [
                /// Account Settings
                TextTile(text: 'Settings', showIcon: false),
                SizedBox(height: ASizes.spaceBtwItems),

                SettingsTile(
                  title: 'Change Password',
                  onPressed: () {
                    GoRouter.of(context).push(
                      '/change_password',
                      extra: {'currentUser': currentUser},
                    );
                  },
                ),
                Divider(),
                SettingsTile(
                  title: 'Notification Preferences',
                  onPressed: () {
                    GoRouter.of(context).push('/notification_preference');
                  },
                ),
                Divider(),

                /// App Settings
                SettingsTile(
                  title: 'Task Completion Rate',
                  onPressed: () {
                    GoRouter.of(context).push('/task_completion_rate');
                  },
                ),
                Divider(),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(ASizes.defaultSpace / 2),
            child: SizedBox(
              width: AHelperFunctions.screenWidth(context),
              child: ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).go('/login');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: Text('Logout', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
