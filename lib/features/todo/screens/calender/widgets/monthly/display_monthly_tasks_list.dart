import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/helpers/helper_function.dart';

class DisplayMonthlyTasksList extends StatelessWidget {
  const DisplayMonthlyTasksList({
    super.key,
    required this.tasks,
    required this.next12MonthsDate,
    required this.selectedMonth,
    required this.selectedMonthIndex,
  });

  final List<List<Map<String, dynamic>>> tasks;
  final List<DateTime> next12MonthsDate;
  final String selectedMonth;
  final int selectedMonthIndex;

  @override
  Widget build(BuildContext context) {
    final selectedMonthLastDay = AHelperFunctions.getDaysInMonth(
      next12MonthsDate[selectedMonthIndex].year,
      next12MonthsDate[selectedMonthIndex].month,
    );

    final selectedMonthDays = AHelperFunctions.createListOfDaysFrom0OfMonth(
      selectedMonthLastDay,
    );

    return Expanded(
      child: ListView.builder(
        itemCount: selectedMonthDays.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,

        itemBuilder: (context, index) {
          final daysString = '${selectedMonthDays[index]} $selectedMonth';

          // This checks if any task matches the condition. save those which matches the current selected Date
          // Also it also checks if the task hour matches any of the hours of that matched date
          // This is done so that we can only display the Divider once and not to display if hours matches

          final matchingTodoTasks =
              tasks[0].where((task) {
                final hourOfTask = DateFormat.jm().format(task['date']);
                final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                  hourOfTask,
                );
                return task['date'].year ==
                        next12MonthsDate[selectedMonthIndex].year &&
                    task['date'].month ==
                        next12MonthsDate[selectedMonthIndex].month &&
                    task['date'].day == selectedMonthDays[index];
              }).toList();

          final matchingEventsTasks =
              tasks[1].where((event) {
                final items = event['items'] as List<dynamic>;
                return items.any((item) {
                  final hourOfTask = DateFormat.jm().format(item['date']);
                  final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                    hourOfTask,
                  );
                  return item['date'].year ==
                          next12MonthsDate[selectedMonthIndex].year &&
                      item['date'].month ==
                          next12MonthsDate[selectedMonthIndex].month &&
                      item['date'].day == selectedMonthDays[index];
                });
              }).toList();

          final matchingMilestonesTasks =
              tasks[2].where((task) {
                final hourOfTask = DateFormat.jm().format(task['due_date']);
                final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                  hourOfTask,
                );
                return task['due_date'].year ==
                        next12MonthsDate[selectedMonthIndex].year &&
                    task['due_date'].month ==
                        next12MonthsDate[selectedMonthIndex].month &&
                    task['due_date'].day == selectedMonthDays[index];
              }).toList();

          final matchingTasks = [
            matchingTodoTasks,
            matchingEventsTasks,
            matchingMilestonesTasks,
          ];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      daysString,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  flex: 5,
                  child: Column(
                    children:
                        matchingTasks.isNotEmpty
                            ? matchingTasks.map<Widget>((tasks) {
                              return Column(
                                children:
                                    tasks.isNotEmpty
                                        ? tasks.map<Widget>((task) {
                                          return task['types'] == 'Event'
                                              ? Column(
                                                children:
                                                    task['items'].map<Widget>((
                                                      item,
                                                    ) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                          color:
                                                              AHelperFunctions.checkTypeOfTask(
                                                                task['types'],
                                                              ),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                        width:
                                                            AHelperFunctions.screenWidth(
                                                              context,
                                                            ),
                                                        height: 50,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 10,
                                                              decoration: BoxDecoration(
                                                                color: AHelperFunctions.checkTypeOfTaskForBorder(
                                                                  task['types'],
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius.only(
                                                                      topLeft:
                                                                          Radius.circular(
                                                                            5,
                                                                          ),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                            5,
                                                                          ),
                                                                    ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                item['title'],
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                              )
                                              : Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      AHelperFunctions.checkTypeOfTask(
                                                        task['types'],
                                                      ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                width:
                                                    AHelperFunctions.screenWidth(
                                                      context,
                                                    ),
                                                height: 50,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AHelperFunctions.checkTypeOfTaskForBorder(
                                                              task['types'],
                                                            ),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                    5,
                                                                  ),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                    5,
                                                                  ),
                                                            ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        task['title'],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                        }).toList()
                                        : [],
                              );
                            }).toList()
                            : [Divider()], // Show only once if no match
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
