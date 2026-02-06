import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AHelperFunctions {
  AHelperFunctions._();

  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show the specific

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static List<T> removeDuplicate<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
        i,
        i + rowSize > widgets.length ? widgets.length : i + rowSize,
      );
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  static String calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  ///---------------DateTime FUNCTIONS----------------///

  static List<DateTime> getNext7Days() {
    DateTime today = DateTime.now();
    List<DateTime> next7Days = List.generate(
      7,
      (i) => today.add(Duration(days: i)),
    );
    return next7Days;
  }

  static List<DateTime> getNext30Days() {
    DateTime today = DateTime.now();
    List<DateTime> next30Days = List.generate(
      30,
      (i) => today.add(Duration(days: i)),
    );
    return next30Days;
  }

  static List<DateTime> getNext12Months() {
    DateTime now = DateTime.now();
    List<DateTime> next12Months = [];

    for (int i = 0; i < 12; i++) {
      DateTime futureMonth = DateTime(now.year, now.month + i);
      next12Months.add(futureMonth);
    }

    return next12Months;
  }

  static List<DateTime> getNext3Years() {
    DateTime now = DateTime.now();
    List<DateTime> next3Years = [];

    for (int i = 0; i < 3; i++) {
      DateTime futureYear = DateTime(
        now.year + i,
        1,
        1,
      ); // January 1st of each year
      next3Years.add(futureYear);
    }
    return next3Years;
  }

  static String getMonthsFromDateTime(DateTime date) {
    String monthName = DateFormat.MMM().format(date); // e.g., January
    return monthName;
  }

  static List<String> getNext12MonthsFromDateTime(List<DateTime> date) {
    List<String> next12Months = [];
    for (int i = 0; i < date.length; i++) {
      String monthName = DateFormat.MMM().format(date[i]); // e.g., January
      next12Months.add(monthName);
    }
    return next12Months;
  }

  static List<String> getNext12MonthsFromCurrentYear(int year) {
    List<String> next12Months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime date = DateTime(year, i);
      String monthName = DateFormat.MMM().format(date); // e.g., January
      next12Months.add(monthName);
    }
    return next12Months;
  }

  static List<DateTime> getNext12MonthsDateFromCurrentYear(int year) {
    List<DateTime> next12Months = [];
    for (int i = 1; i <= 12; i++) {
      DateTime date = DateTime(year, i);
      next12Months.add(date);
    }
    return next12Months;
  }

  // this returns values in 24 hours format.
  static List<DateTime> get24HoursOfADay(DateTime date) {
    List<DateTime> hours = List.generate(
      24,
      (i) => DateTime(date.year, date.month, date.day, i),
    );
    return hours;
  }

  // this returns values as AM/PM, not in 24 hours format.
  static List<String> formatted24HoursTime(List<DateTime> hours) {
    List<String> formattedHourTime = [];
    for (var hour in hours) {
      String formatted = DateFormat.jm().format(hour); //e.g: 2:00 pm
      formattedHourTime.add(formatted);
    }
    return formattedHourTime;
  }

  static int getHourFromStringWithAMPM(String hourString) {
    DateTime time = DateFormat.jm().parse(hourString);
    int hour = time.hour;
    return hour;
  }

  static String getAMPMFromStringWithTime(String hourString) {
    String period = hourString.split(' ').last;
    return period;
  }

  static int getDaysInMonth(int year, int month) {
    DateTime firstDayNextMonth = DateTime(year, month + 1, 1);
    DateTime lastDayCurrentMonth = firstDayNextMonth.subtract(
      Duration(days: 1),
    );
    return lastDayCurrentMonth.day;
  }

  static List<int> createListOfDaysFrom0OfMonth(int lastDay) {
    List<int> days = [];
    for (int i = 1; i <= lastDay; i++) {
      days.add(i);
    }
    return days;
  }

  static Future<DateTime?> selectDate(
    BuildContext context,
    DateTime? selectedDate,
  ) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select a date',
      confirmText: 'Confirm',
      cancelText: 'Cancel',
    );

    return selectedDate;
  }

  ///-----------END DATE TIME--------------------///

  static Color checkTypeOfTask(String type) {
    if (type == 'Todo') {
      return Colors.redAccent;
    } else if (type == 'Event') {
      return Colors.greenAccent;
    } else if (type == 'Milestone') {
      return Colors.blueAccent;
    }
    return Colors.yellowAccent;
  }

  static Color checkTypeOfTaskForBorder(String type) {
    if (type == 'Todo') {
      return Colors.red;
    } else if (type == 'Event') {
      return Colors.green;
    } else if (type == 'Milestone') {
      return Colors.blue;
    }
    return Colors.yellow;
  }

  static double calculateTodoTaskCompletionPerc(Map<String, dynamic> task) {
    if (task['checks'] == null || task['checks'] is! List) {
      print('Invalid or missing checks');
      return 0.0;
    }
    final tasksLength = task['checks'].length;
    final completedTasksLength =
        task['checks']
            .where((check) => check['isCompleted'] == true)
            .toList()
            .length;
    double percentageComplete = (completedTasksLength / tasksLength);
    print('Percent = $percentageComplete');
    return double.parse(percentageComplete.toStringAsFixed(2));
  }

  static Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    VoidCallback onDeleteConfirmed,
    String innerText,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning, color: Colors.red, size: 48),
                SizedBox(height: 12),
                Text(
                  "Are you sure?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(innerText, textAlign: TextAlign.center),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        padding: EdgeInsets.all(8.0),
                      ),
                      icon: Icon(Icons.cancel),
                      label: Text("Cancel"),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.all(8.0),
                      ),
                      icon: Icon(Icons.delete),
                      label: Text("Delete"),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                        onDeleteConfirmed(); // Perform delete action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
