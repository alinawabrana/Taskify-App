import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../utils/helpers/helper_function.dart';

class DisplayDailyTasksList extends StatelessWidget {
  const DisplayDailyTasksList({
    super.key,
    required this.formatted24Hours,
    required this.tasks,
    required this.next7Days,
    required this.selectedDayIndex,
  });

  final List<String> formatted24Hours;
  final List<List<Map<String, dynamic>>> tasks;
  final List<DateTime> next7Days;
  final int selectedDayIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: formatted24Hours.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,

        itemBuilder: (context, index) {
          final hourString = formatted24Hours[index];
          int indexedHour = AHelperFunctions.getHourFromStringWithAMPM(
            hourString,
          );
          final indexedAMPM = AHelperFunctions.getAMPMFromStringWithTime(
            hourString,
          );
          if (indexedAMPM == 'PM') {
            indexedHour += 12;
          }
          if (indexedHour == 12 && indexedAMPM == "AM") {
            indexedHour -= 12;
          }

          // This checks if any task matches the condition. save those which matches the current selected Date
          // Also it also checks if the task hour matches any of the hours of that matched date
          // This is done so that we can only display the Divider once and not to display if hours matches
          print('tasks = ${tasks[0]}');
          final matchingTodoTasks =
              tasks[0].where((task) {
                final hourOfTask = DateFormat.jm().format(task['date']);
                final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                  hourOfTask,
                );
                return task['date'].year == next7Days[selectedDayIndex].year &&
                    task['date'].day == next7Days[selectedDayIndex].day &&
                    taskHour == indexedHour;
              }).toList();

          final matchingEventsTasks =
              tasks[1].where((event) {
                final items = event['items'] as List<dynamic>;
                final type = event['type'];
                return items.any((item) {
                  final hourOfTask = DateFormat.jm().format(item['date']);
                  final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                    hourOfTask,
                  );
                  return type == 'Birthday'
                      ? item['date'].year == next7Days[selectedDayIndex].year &&
                          item['date'].day == next7Days[selectedDayIndex].day &&
                          0 == indexedHour
                      : item['date'].year == next7Days[selectedDayIndex].year &&
                          item['date'].day == next7Days[selectedDayIndex].day &&
                          taskHour == indexedHour;
                });
              }).toList();

          final matchingMilestonesTasks =
              tasks[2].where((task) {
                final hourOfTask = DateFormat.jm().format(task['due_date']);
                final taskHour = AHelperFunctions.getHourFromStringWithAMPM(
                  hourOfTask,
                );
                return task['due_date'].year ==
                        next7Days[selectedDayIndex].year &&
                    task['due_date'].day == next7Days[selectedDayIndex].day &&
                    0 == indexedHour;
              }).toList();

          final matchingTasks = [];

          matchingTasks.add(matchingTodoTasks);
          matchingTasks.add(matchingEventsTasks);
          matchingTasks.add(matchingMilestonesTasks);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: 100,
                    child: Text(
                      hourString,
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
