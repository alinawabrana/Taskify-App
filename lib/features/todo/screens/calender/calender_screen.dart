import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:taskify/common/widgets/tiles/text_tile.dart';
import 'package:taskify/features/todo/screens/calender/widgets/daily/display_daily_tasks_list.dart';
import 'package:taskify/features/todo/screens/calender/widgets/monthly/display_monthly_tasks_list.dart';
import 'package:taskify/features/todo/screens/calender/widgets/monthly/display_next_12_months.dart';
import 'package:taskify/features/todo/screens/calender/widgets/daily/display_next_7_days.dart';
import 'package:taskify/features/todo/screens/calender/widgets/yearly/display_next_3_years.dart';
import 'package:taskify/features/todo/screens/calender/widgets/yearly/display_yearly_tasks_list.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../utils/constants/colors.dart';

class CalenderScreen extends ConsumerWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calenderRiverPod = ref.read(calenderProvider);

    // Next 7 Days data
    final selectedDayIndex = ref.watch(calenderProvider).selectedDateIndex;
    final next30Days = AHelperFunctions.getNext30Days();
    final today24Hours = AHelperFunctions.get24HoursOfADay(DateTime.now());
    final formatted24Hours = AHelperFunctions.formatted24HoursTime(
      today24Hours,
    );
    final selectedDay = ref.watch(calenderProvider).selectedDay;

    // Next 12 Months Data
    final selectedMonthIndex = ref.watch(calenderProvider).selectedMonthIndex;
    final next12MonthsDates = AHelperFunctions.getNext12Months();
    final next12MonthsNames = AHelperFunctions.getNext12MonthsFromDateTime(
      next12MonthsDates,
    );
    final selectedMonth = ref.watch(calenderProvider).selectedMonth;

    // Next 3 Years Data
    final selectedYearIndex = ref.watch(calenderProvider).selectedYearIndex;
    final selectedYearMonthIndex =
        ref.watch(calenderProvider).selectedYearMonthIndex;
    final next3YearsDates = AHelperFunctions.getNext3Years();
    final selectedYear = ref.watch(calenderProvider).selectedYear;
    final selectedYearMonth = ref.watch(calenderProvider).selectedYearMonth;
    final currentYearMonths = AHelperFunctions.getNext12MonthsFromCurrentYear(
      selectedYear,
    );
    final currentYearMonthsDates =
        AHelperFunctions.getNext12MonthsDateFromCurrentYear(selectedYear);

    final todo = ref.watch(taskProvider).todoTasks;
    final events = ref.watch(taskProvider).events;
    final milestones = ref.watch(taskProvider).milestones;
    final tasks = [todo, events, milestones];
    final selectedDropDownItem =
        ref.watch(calenderProvider).selectedDropDownItem;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 20, color: Colors.redAccent),
                SizedBox(height: 2),
                Text('Todo', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 20, color: Colors.blueAccent),
                SizedBox(height: 2),
                Text('Milestones', style: TextStyle(fontSize: 10)),
              ],
            ),
            SizedBox(width: 5),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 20, height: 20, color: Colors.greenAccent),
                SizedBox(height: 2),
                Text('Events', style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        actions: [
          Text(
            'Showing results:',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(fontSizeFactor: 0.7),
          ),
          SizedBox(width: 16),
          DropdownButton<String>(
            value: selectedDropDownItem,
            items:
                ['Daily', 'Monthly', 'Yearly'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        value,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge!.apply(fontSizeFactor: 0.8),
                      ),
                    ),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                calenderRiverPod.changeDropDownItem(newValue);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          children: [
            selectedDropDownItem == 'Daily'
                ?
                /// Display Next 7 Days
                DisplayNext7Days(
                  selectedDayIndex: selectedDayIndex,
                  next30Days: next30Days,
                  calenderRiverPod: calenderRiverPod,
                )
                : selectedDropDownItem == 'Monthly'
                ?
                /// Display Next 12 Months
                DisplayNext12Months(
                  selectedMonthIndex: selectedMonthIndex,
                  next12MonthsDates: next12MonthsDates,
                  next12MonthsNames: next12MonthsNames,
                  calenderRiverPod: calenderRiverPod,
                )
                : Column(
                  children: [
                    DisplayNext3Years(
                      selectedYearIndex: selectedYearIndex,
                      next3YearsDates: next3YearsDates,
                      calenderRiverPod: calenderRiverPod,
                    ),
                    SizedBox(height: 15),
                    DisplayNext12Months(
                      selectedMonthIndex: selectedYearMonthIndex,
                      next12MonthsDates: currentYearMonthsDates,
                      next12MonthsNames: currentYearMonths,
                      calenderRiverPod: calenderRiverPod,
                      isCurrentYearsMonths: true,
                    ),
                  ],
                ),

            SizedBox(height: ASizes.spaceBtwSections),

            selectedDropDownItem == 'Daily'
                ? TextTile(text: '$selectedDay Tasks', showIcon: false)
                : selectedDropDownItem == 'Monthly'
                ? TextTile(text: '$selectedMonth Tasks', showIcon: false)
                : TextTile(
                  text: '$selectedYearMonth $selectedYear Tasks',
                  showIcon: false,
                ),
            SizedBox(height: ASizes.spaceBtwItems),

            /// Displaying the Tasks
            selectedDropDownItem == 'Daily'
                ?
                /// Displaying Hours + Related Tasks
                DisplayDailyTasksList(
                  formatted24Hours: formatted24Hours,
                  tasks: tasks,
                  next7Days: next30Days,
                  selectedDayIndex: selectedDayIndex,
                )
                : selectedDropDownItem == 'Monthly'
                ?
                /// Displaying Days + Related Tasks
                DisplayMonthlyTasksList(
                  tasks: tasks,
                  next12MonthsDate: next12MonthsDates,
                  selectedMonth: selectedMonth,
                  selectedMonthIndex: selectedMonthIndex,
                )
                : DisplayYearlyTasksList(
                  tasks: tasks,
                  selectedYear: selectedYear,
                  next12MonthsDate: currentYearMonthsDates,
                  selectedYearMonth: selectedYearMonth,
                  selectedYearMonthIndex: selectedYearMonthIndex,
                ),
          ],
        ),
      ),
    );
  }
}
