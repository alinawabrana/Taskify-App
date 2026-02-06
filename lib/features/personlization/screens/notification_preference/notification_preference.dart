import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/features/personlization/screens/notification_preference/widget/notification_tile.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class NotificationPreference extends ConsumerStatefulWidget {
  const NotificationPreference({super.key});

  @override
  ConsumerState<NotificationPreference> createState() =>
      _NotificationPreferenceState();
}

class _NotificationPreferenceState
    extends ConsumerState<NotificationPreference> {
  @override
  Widget build(BuildContext context) {
    final settingRead = ref.read(settingProvider);
    final settingWatch = ref.watch(settingProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Preference',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AColors.primaryColor,
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
                  NotificationTile(
                    title: 'Todo',
                    settingRead: settingRead,
                    settingWatch: settingWatch,
                    isTodo: true,
                    onChange: () => setState(() {}),
                  ),
                  Divider(),
                  NotificationTile(
                    title: 'Event',
                    settingRead: settingRead,
                    settingWatch: settingWatch,
                    isEvent: true,
                    onChange: () => setState(() {}),
                  ),
                  Divider(),
                  NotificationTile(
                    title: 'Milestone',
                    settingRead: settingRead,
                    settingWatch: settingWatch,
                    onChange: () => setState(() {}),
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
