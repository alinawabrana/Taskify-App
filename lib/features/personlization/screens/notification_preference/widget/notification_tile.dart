import 'package:flutter/material.dart';
import 'package:taskify/features/personlization/controllers/setting_riverpod.dart';
import 'package:taskify/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    this.isTodo = false,
    this.isEvent = false,
    required this.settingRead,
    required this.settingWatch,
    required this.onChange,
    required this.title,
  });

  final bool isTodo;
  final bool isEvent;
  final SettingRiverPod settingRead;
  final SettingRiverPod settingWatch;
  final VoidCallback onChange;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 160,
              child: Text(
                '$title Notification:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: ASizes.spaceBtwItems),
            Flexible(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(
                  horizontal:
                      VisualDensity
                          .minimumDensity, // Reduces horizontal spacing
                  vertical:
                      VisualDensity.minimumDensity, // Reduces vertical spacing
                ),
                title: Text(
                  'No',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                value: 'No',
                groupValue:
                    isTodo
                        ? settingWatch.turnTodoNotification
                        : isEvent
                        ? settingWatch.turnEventsNotification
                        : settingWatch.turnMilestonesNotification,
                onChanged: (String? value) {
                  isTodo
                      ? settingRead.changeTodoNotification(value!)
                      : isEvent
                      ? settingRead.changeEventsNotification(value!)
                      : settingRead.changeMilestonesNotification(value!);
                  onChange;
                },
              ),
            ),
            Flexible(
              child: RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity(
                  horizontal:
                      VisualDensity
                          .minimumDensity, // Reduces horizontal spacing
                  vertical:
                      VisualDensity.minimumDensity, // Reduces vertical spacing
                ),
                title: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                value: 'Yes',
                groupValue:
                    isTodo
                        ? settingWatch.turnTodoNotification
                        : isEvent
                        ? settingWatch.turnEventsNotification
                        : settingWatch.turnMilestonesNotification,
                onChanged: (String? value) {
                  isTodo
                      ? settingRead.changeTodoNotification(value!)
                      : isEvent
                      ? settingRead.changeEventsNotification(value!)
                      : settingRead.changeMilestonesNotification(value!);
                  onChange;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: ASizes.spaceBtwItems / 4),
        (isTodo
                    ? settingWatch.turnTodoNotification
                    : isEvent
                    ? settingWatch.turnEventsNotification
                    : settingWatch.turnMilestonesNotification) ==
                'Yes'
            ? Row(
              children: [
                Text('Notify Me ', style: TextStyle(color: Colors.white)),
                SizedBox(width: ASizes.spaceBtwItems),
                DropdownButton<String>(
                  dropdownColor: AColors.dark,
                  value:
                      isTodo
                          ? settingWatch.selectedTodoTime
                          : isEvent
                          ? settingWatch.selectedEventTime
                          : settingWatch.selectedMilestoneTime,
                  items:
                      ['1', '2', '3'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              value,
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge!.apply(
                                fontSizeFactor: 0.8,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      isTodo
                          ? settingRead.changeTodoTime(newValue)
                          : isEvent
                          ? settingRead.changeEventTime(newValue)
                          : settingRead.changeMilestoneTime(newValue);
                    }
                  },
                ),
                SizedBox(width: ASizes.spaceBtwItems),
                Text(
                  'Days before Deadline',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )
            : SizedBox(),
      ],
    );
  }
}
