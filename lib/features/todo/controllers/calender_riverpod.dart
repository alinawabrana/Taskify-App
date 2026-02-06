import 'package:flutter/material.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class CalenderRiverPod extends ChangeNotifier {
  int selectedDateIndex = 0;
  int selectedMonthIndex = 0;
  int selectedYearIndex = 0;
  int selectedYearMonthIndex = 0;
  String selectedDay = 'Today\'s';
  String selectedMonth = AHelperFunctions.getMonthsFromDateTime(DateTime.now());
  String selectedYearMonth = AHelperFunctions.getMonthsFromDateTime(
    DateTime(DateTime.now().year, 1),
  );
  int selectedYear = DateTime.now().year;
  String selectedDropDownItem = 'Daily';

  void changeDateIndex(int index) {
    selectedDateIndex = index;
    notifyListeners();
  }

  void changeMonthIndex(int index) {
    selectedMonthIndex = index;
    notifyListeners();
  }

  void changeYearIndex(int index) {
    selectedYearIndex = index;
    notifyListeners();
  }

  void changeYearMonthIndex(int index) {
    selectedYearMonthIndex = index;
    notifyListeners();
  }

  void changeDayName(String name) {
    selectedDay = name;
    notifyListeners();
  }

  void changeMonthName(String name) {
    selectedMonth = name;
    notifyListeners();
  }

  void changeYear(int year) {
    selectedYear = year;
    notifyListeners();
  }

  void changeYearMonthName(String name) {
    selectedYearMonth = name;
    notifyListeners();
  }

  void changeDropDownItem(String value) {
    selectedDropDownItem = value;
    notifyListeners();
  }
}
