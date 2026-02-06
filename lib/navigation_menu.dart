import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/common/widgets/overlay_dropdown/overlay_dropdown.dart';
import 'package:taskify/features/todo/screens/calender/calender_screen.dart';
import 'package:taskify/features/todo/screens/home/home_screen.dart';
import 'package:taskify/features/todo/screens/search/search_screen.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import 'features/personlization/screens/setting/setting_screen.dart';

class BottomAppBarMenu extends ConsumerStatefulWidget {
  const BottomAppBarMenu({super.key});

  @override
  ConsumerState<BottomAppBarMenu> createState() => _BottomAppBarMenuState();
}

class _BottomAppBarMenuState extends ConsumerState<BottomAppBarMenu> {
  @override
  Widget build(BuildContext context) {
    final LayerLink _addLink = LayerLink();
    final isDark = AHelperFunctions.isDarkMode(context);

    final selectedScreenIndex =
        ref.watch(navigationProvider).selectedScreenIndex;
    final navigationRiverPod = ref.read(navigationProvider);

    final List<Map<String, dynamic>> options = [
      {'name': 'Todo Tasks', 'navigate': '/new_todo'},
      {'name': 'Events', 'navigate': '/new_events'},
      {'name': 'Milestones/Goals', 'navigate': '/new_milestones'},
    ];

    List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      CalenderScreen(),
      SettingScreen(),
    ];

    List<Map<String, dynamic>> navigationList = [
      {'icon': Iconsax.home, 'name': 'Home'},
      {'icon': Iconsax.search_normal, 'name': 'Search'},
      {'icon': Iconsax.calendar_1, 'name': 'Calender'},
      {'icon': Iconsax.setting, 'name': 'Settings'},
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blueAccent,
        shape: CircleBorder(),
        child: OverlayDropdown(
          linkLayer: _addLink,
          icon: Iconsax.add,
          size: 32,
          color: Colors.white,
          isFloatingButton: true,
          options: options,
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4,
        elevation: 8,
        color: isDark ? AColors.primaryColor : Colors.grey.shade100,
        height: 75,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1.9,
          ),
          itemCount: navigationList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            bool isSelected = selectedScreenIndex == index;
            final menu = navigationList[index];
            return GestureDetector(
              onTap: () {
                navigationRiverPod.changeSelectedScreenIndex(index);
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isSelected
                          ? Colors.blueAccent.shade100.withOpacity(0.2)
                          : Colors.transparent,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      menu['icon'],
                      size: 20,
                      color:
                          isSelected
                              ? Colors.blueAccent.shade700
                              : isDark
                              ? Colors.white
                              : Colors.black,
                    ),
                    Text(
                      menu['name'],
                      style: TextStyle(
                        fontSize: 9,
                        color:
                            isSelected
                                ? Colors.blueAccent.shade700
                                : isDark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

      body: screens[selectedScreenIndex],
    );
  }
}
