import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/features/personlization/controllers/setting_riverpod.dart';
import 'package:taskify/features/todo/controllers/calender_riverpod.dart';
import 'package:taskify/features/todo/controllers/home_controller_riverpod.dart';
import 'package:taskify/features/todo/controllers/navigation_riverpod.dart';
import 'package:taskify/features/todo/controllers/task_riverpod.dart';

final taskProvider = ChangeNotifierProvider((ref) => TasksRiverPod());
final calenderProvider = ChangeNotifierProvider((ref) => CalenderRiverPod());
final homeProvider = ChangeNotifierProvider((ref) => HomeRiverPod());
final navigationProvider = ChangeNotifierProvider(
  (ref) => NavigationRiverPod(),
);
final settingProvider = ChangeNotifierProvider((ref) => SettingRiverPod());
