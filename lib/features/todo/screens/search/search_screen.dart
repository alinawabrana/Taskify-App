import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:taskify/common/widgets/event_overview_container_row/event_overview_container_row.dart';
import 'package:taskify/common/widgets/milestone_overview_container_row/milestone_overview_container_row.dart';
import 'package:taskify/common/widgets/search_bar.dart';
import 'package:taskify/common/widgets/todo_overview_container_row/todo_overview_container_row.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../common/widgets/overlay_dropdown/overlay_dropdown_priority.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  SearchController searchController = SearchController();

  @override
  Widget build(BuildContext context) {
    final taskWatch = ref.watch(taskProvider);
    final filter = ref.watch(taskProvider).filterTasks;
    final tasks = filter == 'all' ? taskWatch.getSearchedList() : [];
    final filterTasks =
        filter == 'todo'
            ? taskWatch.getSearchedTodoList()
            : filter == 'events'
            ? taskWatch.getSearchedEventsList()
            : taskWatch.getSearchedMilestonesList();

    LayerLink _filterLink = LayerLink();

    List<Map<String, dynamic>> filters = [
      {'filter': 'all'},
      {'filter': 'todo'},
      {'filter': 'events'},
      {'filter': 'milestones'},
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: ASearchBarTextField(
          searchController: searchController,
          ref: ref,
          hintText: 'Search Tasks....',
          prefixIcon: Icon(Iconsax.search_normal),
          onChange: true,
        ),
        actions: [
          Text('Filter: ', style: TextStyle(fontSize: 13)),
          SizedBox(
            width: 120,
            child: OverlayDropdownPriority(
              linkLayer: _filterLink,
              options: filters,
              isFilter: true,
              ref: ref,
              onTap: () {
                setState(() {});
              },
              fontSize: 15,
              iconSize: 12,
              fontColor: Colors.black,
              iconColor: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child:
            filter == 'all'
                ? tasks.isEmpty
                    ? Text('Not Found')
                    : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final taskLists = tasks[index];
                        if (index == 0) {
                          return Column(
                            children:
                                taskLists.map<Widget>((task) {
                                  return TodoOverviewContainerRow(
                                    task: task,
                                    percent: task['percentCompleted'],
                                  );
                                }).toList(),
                          );
                        } else if (index == 1) {
                          return Column(
                            children:
                                taskLists.expand<Widget>((task) {
                                  final type = task['type'];
                                  final items = task['items'] as List;
                                  return items.map<Widget>((item) {
                                    return EventOverviewContainerRow(
                                      eventType: type,
                                      item: item,
                                    );
                                  });
                                }).toList(),
                          );
                        } else {
                          return Column(
                            children:
                                taskLists.map<Widget>((task) {
                                  return MilestoneOverviewContainerRow(
                                    milestone: task,
                                  );
                                }).toList(),
                          );
                        }
                      },
                    )
                : ListView.builder(
                  itemCount: filterTasks.length,
                  itemBuilder: (context, index) {
                    final task = filterTasks[index];
                    return filter == 'todo'
                        ? TodoOverviewContainerRow(
                          task: task,
                          percent: task['percentCompleted'],
                        )
                        : filter == 'events'
                        ? Column(
                          children:
                              task['items']
                                  .map<Widget>(
                                    (item) => EventOverviewContainerRow(
                                      eventType: task['type'],
                                      item: item,
                                    ),
                                  )
                                  .toList(),
                        )
                        : MilestoneOverviewContainerRow(milestone: task);
                  },
                ),
      ),
    );
  }
}
