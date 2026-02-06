import 'package:flutter/material.dart';

class SettingRiverPod extends ChangeNotifier {
  Map<String, dynamic> user = {
    'firstName': 'Ali Nawab',
    'lastName': 'Rana',
    'username': 'alinawab',
    'email': 'alinawabrana@gmail.com',
    'imageUrl': 'assets/icons/user-setting-icon-anonymous-person-symbol.png',
  };

  String turnTodoNotification = 'No';
  String turnEventsNotification = 'No';
  String turnMilestonesNotification = 'No';

  String selectedTodoTime = '1';
  String selectedEventTime = '2';
  String selectedMilestoneTime = '3';

  void changeTodoNotification(String value) {
    turnTodoNotification = value;
    notifyListeners();
  }

  void changeEventsNotification(String value) {
    turnEventsNotification = value;
    notifyListeners();
  }

  void changeMilestonesNotification(String value) {
    turnMilestonesNotification = value;
    notifyListeners();
  }

  void changeTodoTime(String value) {
    selectedTodoTime = value;
    notifyListeners();
  }

  void changeEventTime(String value) {
    selectedEventTime = value;
    notifyListeners();
  }

  void changeMilestoneTime(String value) {
    selectedMilestoneTime = value;
    notifyListeners();
  }
}
