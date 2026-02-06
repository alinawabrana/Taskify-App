import 'package:flutter/material.dart';

class HomeRiverPod extends ChangeNotifier {
  int selectedCardIndex = 0;
  List<String> taskTypes = ['To Do', 'Upcoming\nEvents', 'Goals/MileStones'];

  void changeSelectedCardIndex(int index) {
    selectedCardIndex = index;
    notifyListeners();
  }
}
