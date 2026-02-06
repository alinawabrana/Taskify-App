import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_function.dart';
import '../../../../controllers/calender_riverpod.dart';

class DisplayNext3Years extends StatelessWidget {
  const DisplayNext3Years({
    super.key,
    required this.selectedYearIndex,
    required this.next3YearsDates,
    required this.calenderRiverPod,
  });

  final int selectedYearIndex;
  final List<DateTime> next3YearsDates;
  final CalenderRiverPod calenderRiverPod;

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return SizedBox(
      height: 60,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: next3YearsDates.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          bool isSelected = selectedYearIndex == index;
          return GestureDetector(
            onTap: () {
              calenderRiverPod.changeYearIndex(index);

              int year = next3YearsDates[index].year;
              calenderRiverPod.changeYear(year);
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
                child: Center(
                  child: Text(
                    "${next3YearsDates[index].year}",
                    style: Theme.of(context).textTheme.headlineSmall!.apply(
                      color: isSelected ? Colors.white : Colors.black,
                      fontSizeFactor: 0.8,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
