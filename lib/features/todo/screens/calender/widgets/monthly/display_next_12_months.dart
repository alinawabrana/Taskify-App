import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_function.dart';
import '../../../../controllers/calender_riverpod.dart';

class DisplayNext12Months extends StatelessWidget {
  const DisplayNext12Months({
    super.key,
    required this.selectedMonthIndex,
    required this.next12MonthsDates,
    required this.next12MonthsNames,
    required this.calenderRiverPod,
    this.isCurrentYearsMonths = false,
  });

  final int selectedMonthIndex;
  final List<String> next12MonthsNames;
  final List<DateTime> next12MonthsDates;
  final CalenderRiverPod calenderRiverPod;
  final bool isCurrentYearsMonths;

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 60,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: next12MonthsDates.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          bool isSelected = selectedMonthIndex == index;
          final date = next12MonthsDates[index];
          return GestureDetector(
            onTap: () {
              print(index);
              isCurrentYearsMonths
                  ? calenderRiverPod.changeYearMonthIndex(index)
                  : calenderRiverPod.changeMonthIndex(index);

              String name = next12MonthsNames[index];
              isCurrentYearsMonths
                  ? calenderRiverPod.changeYearMonthName(name)
                  : calenderRiverPod.changeMonthName(name);
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
                      next12MonthsNames[index],
                      style: Theme.of(context).textTheme.headlineSmall!.apply(
                        color: isSelected ? Colors.white : Colors.black,
                        fontSizeFactor: 0.8,
                      ),
                    ),
                    Text(
                      date.year.toString(),
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
