import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/features/todo/controllers/calender_riverpod.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../../../utils/constants/colors.dart';

class DisplayNext7Days extends StatelessWidget {
  const DisplayNext7Days({
    super.key,
    required this.selectedDayIndex,
    required this.next30Days,
    required this.calenderRiverPod,
  });

  final int selectedDayIndex;
  final List<DateTime> next30Days;
  final CalenderRiverPod calenderRiverPod;

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 60,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: next30Days.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          bool isSelected = selectedDayIndex == index;
          final date = next30Days[index];
          return GestureDetector(
            onTap: () {
              print(index);
              calenderRiverPod.changeDateIndex(index);
              if (index == 0) {
                calenderRiverPod.changeDayName('Today\'s');
              } else if (index == 1) {
                calenderRiverPod.changeDayName('Tomorrow\'s');
              } else {
                String name = '${date.day} ${DateFormat.MMM().format(date)}';
                calenderRiverPod.changeDayName(name);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:
                    isSelected
                        ? AColors.primaryColor
                        : isDark
                        ? Colors.white70
                        : Colors.grey.shade50,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      date.day.toString(),
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSizeFactor: 0.8,
                      ),
                    ),
                    Text(
                      DateFormat('EEE').format(date),
                      style: Theme.of(context).textTheme.labelMedium!.apply(
                        fontSizeFactor: 0.8,
                        color:
                            isSelected
                                ? Colors.white
                                : Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
