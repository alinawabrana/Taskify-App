import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/common/widgets/event_overview_container_row/event_overview_container_row.dart';
import 'package:taskify/common/widgets/images/circular_image_container.dart';
import 'package:taskify/common/widgets/milestone_overview_container_row/milestone_overview_container_row.dart';
import 'package:taskify/common/widgets/overlay_dropdown/overlay_dropdown.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../common/widgets/tiles/text_tile.dart';
import '../../../../common/widgets/todo_overview_container_row/todo_overview_container_row.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);

    final LayerLink _menuLink = LayerLink();
    final LayerLink _notificationLink = LayerLink();

    final homeRiverPod = ref.read(homeProvider);
    final selectedCardIndex = ref.watch(homeProvider).selectedCardIndex;
    final taskRiverPod = ref.watch(taskProvider);
    final currentUser = ref.watch(settingProvider).user;

    final List<Map<String, dynamic>> menuOptions = [
      {
        'name': 'Profile',
        'navigate': '/setting',
        'extra': {'currentUser': currentUser},
      },
      {'name': 'Search', 'navigate': '/search', 'extra': null},
      {'name': 'Settings', 'navigate': '/setting', 'extra': null},
    ];

    final List<Map<String, dynamic>> notificationOptions = [
      {'name': 'Order Update', 'navigate': '', 'extra': null},
      {'name': 'New Message', 'navigate': '', 'extra': null},
      {'name': 'Settings', 'navigate': '', 'extra': null},
    ];

    // Tasks Types
    final taskTypes = ref.watch(homeProvider).taskTypes;
    ref.read(taskProvider).calculateTotalEvents();
    ref.read(taskProvider).calculateTotalTodos();
    ref.read(taskProvider).calculateTotalMilestones();

    // To Dos
    final tasks =
        taskRiverPod.todoTasks
            .where((task) => task['priority'] == 'High')
            .toList();

    // Events
    final events = taskRiverPod.events;

    // Milestones
    final milestones =
        taskRiverPod.milestones
            .where((milestone) => milestone['priority'] == 'High')
            .toList();
    ;

    // Counts of each task type
    final totalTodos = ref.watch(taskProvider).totalTodos;
    final totalEvents = ref.watch(taskProvider).totalEvents;
    final totalMilestones = ref.watch(taskProvider).totalMilestones;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircularImageContainer(imageUrl: 'assets/logo/Taskify_Logo.png'),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Task Buddy!',
                  style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                Text(
                  '${currentUser['firstName']} ${currentUser['lastName']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: AColors.primaryColor,

        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OverlayDropdown(
                linkLayer: _menuLink,
                icon: Icons.menu,
                options: menuOptions,
              ),
              OverlayDropdown(
                linkLayer: _notificationLink,
                icon: Icons.notifications,
                options: notificationOptions,
              ),
              SizedBox(width: 8), // Default search icon
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Column(
          children: [
            TextTile(
              text: 'Tasks Review',
              showIcon: true,
              suffix: Icon(Iconsax.calendar_1),
              onPressed: () => GoRouter.of(context).push('/calender'),
            ),

            /// Choose from the provided option
            SizedBox(
              height: 150,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: taskTypes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  bool isSelected = selectedCardIndex == index;
                  return GestureDetector(
                    onTap: () => homeRiverPod.changeSelectedCardIndex(index),
                    child: Card(
                      color:
                          isSelected
                              ? AColors.primaryColor
                              : isDark
                              ? Colors.white70
                              : Colors.grey.shade50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: ASizes.defaultSpace * 0.8,
                          vertical: ASizes.defaultSpace * 0.9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              taskTypes[index] == 'To Do'
                                  ? totalTodos.toString()
                                  : taskTypes[index] == 'Upcoming\nEvents'
                                  ? totalEvents.toString()
                                  : totalMilestones.toString(),
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: Text(
                                    taskTypes[index],
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Iconsax.arrow_right_1,
                                  size: 15,
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: ASizes.spaceBtwSections),

            taskTypes[selectedCardIndex] == 'To Do'
                ? Expanded(
                  child: Column(
                    children: [
                      /// Priority Tasks Lists
                      TextTile(
                        text: 'Priority Task',
                        showIcon: true,
                        suffix: Text(
                          'See All',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () => GoRouter.of(context).push('/todo'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks[index];
                            return TodoOverviewContainerRow(
                              task: task,
                              percent: task['percentCompleted'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
                : taskTypes[selectedCardIndex] == 'Upcoming\nEvents'
                ? Expanded(
                  child: ListView.builder(
                    itemCount: events.fold<int>(
                      0,
                      (count, e) => count + 1 + (e['items'] as List).length,
                    ),
                    itemBuilder: (context, index) {
                      int runningIndex = 0;

                      for (final event in events) {
                        final eventType = event['type'];
                        final allItems = event['items'] as List;
                        final items = allItems.take(3).toList();
                        final headerIndex = runningIndex;

                        if (index == headerIndex) {
                          return items.isNotEmpty
                              ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTile(
                                    text: '$eventType\'s',
                                    showIcon: true,
                                    suffix: Text(
                                      'See All',
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    onPressed:
                                        () => GoRouter.of(context).push(
                                          '/events/${eventType.toString()}',
                                        ),
                                  ),
                                  SizedBox(height: ASizes.spaceBtwItems),
                                ],
                              )
                              : Container();
                        }

                        final itemIndex = index - headerIndex - 1;

                        if (itemIndex < items.length) {
                          final item = items[itemIndex];
                          return EventOverviewContainerRow(
                            eventType: eventType,
                            item: item,
                          );
                        }

                        runningIndex += 1 + (items).length;
                      }

                      return SizedBox(); // Fallback
                    },
                  ),
                )
                : Expanded(
                  child: Column(
                    children: [
                      TextTile(
                        text: 'Priority Milestones',
                        showIcon: true,
                        suffix: Text(
                          'See All',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed:
                            () => GoRouter.of(context).push('/milestones'),
                      ),
                      SizedBox(height: ASizes.spaceBtwItems),
                      Expanded(
                        child: ListView.builder(
                          itemCount: milestones.length,
                          itemBuilder: (context, index) {
                            final milestone = milestones[index];
                            return MilestoneOverviewContainerRow(
                              milestone: milestone,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
