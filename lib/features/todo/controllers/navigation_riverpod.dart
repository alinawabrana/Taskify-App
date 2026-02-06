import 'package:flutter/material.dart';

class NavigationRiverPod extends ChangeNotifier {
  int selectedScreenIndex = 0;

  void changeSelectedScreenIndex(int index) {
    selectedScreenIndex = index;
    notifyListeners();
  }
}
