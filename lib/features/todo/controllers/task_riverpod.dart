import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/utils/loaders/loaders.dart';

class TasksRiverPod extends ChangeNotifier {
  String searchText = '';
  List<Map<String, dynamic>> todoTasks = [
    {
      'todo_id': 1,
      'month': DateFormat.MMM().format(DateTime.now()),
      'date': DateTime.now(),
      'title': 'ALi',
      'subTitle': 'A Professional Flutter Developer',
      'types': 'Todo',
      'priority': 'High',
      'percentCompleted': 0.3,
      'checks': [
        {'checkTitle': 'Complete the FrontEnd', 'isCompleted': true},
        {'checkTitle': 'Complete the Backend', 'isCompleted': false},
        {'checkTitle': 'Complete the Database', 'isCompleted': false},
      ],
    },
    {
      'todo_id': 2,
      'month': DateFormat.MMM().format(DateTime(2025, 7, 1, 12)),
      'date': DateTime(2025, 7, 1, 12),
      'title': 'ALi',
      'subTitle': 'A Professional Flutter',
      'types': 'Todo',
      'priority': 'High',
      'percentCompleted': 0.3,
      'checks': [
        {'checkTitle': 'Complete the FrontEnd', 'isCompleted': true},
        {'checkTitle': 'Complete the Backend', 'isCompleted': false},
        {'checkTitle': 'Complete the Database', 'isCompleted': false},
      ],
    },
    {
      'todo_id': 3,
      'month': DateFormat.MMM().format(DateTime.now()),
      'date': DateTime.now(),
      'title': 'ALi Nawab',
      'subTitle': 'A Professional Flutter Developer',
      'types': 'Todo',
      'priority': 'Low',
      'percentCompleted': 0.3,
      'checks': [
        {'checkTitle': 'Complete the FrontEnd', 'isCompleted': true},
        {'checkTitle': 'Complete the Backend', 'isCompleted': false},
        {'checkTitle': 'Complete the Database', 'isCompleted': false},
      ],
    },
  ];

  List<Map<String, dynamic>> events = [
    {
      'type': 'Birthday',
      'types': 'Event',
      'items': [
        {
          'date': DateTime.now(),
          'month': DateFormat.MMM().format(DateTime.now()),
          'title': 'Ali\'s birthday',
        },
        {
          'date': DateTime.now(),
          'month': DateFormat.MMM().format(DateTime.now()),
          'title': 'Ali\'s birthday',
        },
        {
          'date': DateTime.now(),
          'month': DateFormat.MMM().format(DateTime.now()),
          'title': 'Ali\'s birthday',
        },
        {
          'date': DateTime.now(),
          'month': DateFormat.MMM().format(DateTime.now()),
          'title': 'Ali\'s birthday',
        },
      ],
    },
    {
      'type': 'Meeting',
      'types': 'Event',
      'items': [
        {
          'date': DateTime(2025, 6, 4, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 6, 4, 6)),
          'time': DateFormat.jm().format(DateTime(2025, 6, 4, 6)),
          'title': 'FYP Meeting',
          'withWhom': 'Ali Nawab Rana',
          'reason': 'To discuss the further details of FYP',
        },
        {
          'date': DateTime(2025, 6, 4, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 6, 4, 6)),
          'time': DateFormat.jm().format(DateTime(2025, 6, 4, 6)),
          'title': 'FYP Meeting',
          'withWhom': 'Ali Nawab Rana',
          'reason': 'To discuss the further details of FYP',
        },
      ],
    },
    {
      'type': 'Wedding',
      'types': 'Event',
      'items': [
        {
          'date': DateTime(2025, 7, 4, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 7, 4, 6)),
          'time': 'Day',
          'title': 'Ali\'s wedding',
        },
        {
          'date': DateTime(2025, 7, 4, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 7, 4, 6)),
          'time': 'Day',
          'title': 'Ali\'s wedding',
        },
      ],
    },
    {
      'type': 'Custom',
      'types': 'Event',
      'items': [
        {
          'date': DateTime(2025, 6, 15, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 6, 15, 6)),
          'event_type': 'sports',
          'title': 'Lasalle Sports meet',
        },
        {
          'date': DateTime(2025, 6, 15, 6),
          'month': DateFormat.MMM().format(DateTime(2025, 6, 15, 6)),
          'event_type': 'sports',
          'title': 'Lasalle Sports meet',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> milestones = [
    {
      'milestone_id': 1,
      'types': 'Milestone',
      'due_date': DateTime(2025, 6, 15),
      'month': DateFormat.MMM().format(DateTime(2025, 6, 15)),
      'title': 'Complete Frontend of Taskify',
      'description': '''This is the milestone of one of my university projects:

In this milestone the following should be done:
SMANXBAX''',
      'priority': 'High',
      'isCompleted': false,
    },
    {
      'milestone_id': 2,
      'types': 'Milestone',
      'due_date': DateTime(2025, 6, 19),
      'month': DateFormat.MMM().format(DateTime(2025, 6, 15)),
      'title': 'Complete Frontend of Taskify',
      'description': '''This is the milestone of one of my university projects:

In this milestone the following should be done:
(1) ABC
(2) DEF
(3) GHI ''',
      'priority': 'High',
      'isCompleted': true,
    },
    {
      'milestone_id': 3,
      'types': 'Milestone',
      'due_date': DateTime(2025, 6, 20),
      'month': DateFormat.MMM().format(DateTime(2025, 6, 15)),
      'title': 'Complete Frontend of Taskify',
      'description': '',
      'priority': 'Low',
      'isCompleted': true,
    },
    {
      'milestone_id': 4,
      'types': 'Milestone',
      'due_date': DateTime(2025, 6, 28),
      'month': DateFormat.MMM().format(DateTime(2025, 6, 15)),
      'title': 'Complete Frontend of Taskify',
      'description': '',
      'priority': 'High',
      'isCompleted': false,
    },
  ];

  int totalEvents = 0;
  int totalTodos = 0;
  int totalMilestones = 0;

  bool showHistory = false;
  bool addMoreTodo = false;

  String filterTasks = 'all';

  void changeFilter(String filter) {
    filterTasks = filter;
    notifyListeners();
  }

  List<List<Map<String, dynamic>>> getSearchedList() {
    List<List<Map<String, dynamic>>> tasks = [];
    if (searchText == '') {
      tasks.add(todoTasks);
      tasks.add(events);
      tasks.add(milestones);
      return tasks;
    }

    final searchTask = searchText.toLowerCase();

    List<Map<String, dynamic>> matchedTodoItems =
        todoTasks
            .where((item) => item['title'].toLowerCase().contains(searchTask))
            .toList();

    tasks.add(matchedTodoItems);

    List<Map<String, dynamic>> matchedEventsItems =
        events.where((event) {
          final items = event['items'] as List<dynamic>;
          return items.any(
            (item) =>
                (item['title'] as String).toLowerCase().contains(searchTask),
          );
        }).toList();

    tasks.add(matchedEventsItems);

    List<Map<String, dynamic>> matchedMilestonesItems =
        milestones
            .where((item) => item['title'].toLowerCase().contains(searchTask))
            .toList();

    tasks.add(matchedMilestonesItems);

    return tasks;
  }

  List<Map<String, dynamic>> getSearchedTodoList() {
    if (searchText == '') return todoTasks;

    final searchTask = searchText.toLowerCase();

    List<Map<String, dynamic>> matchedItems =
        todoTasks
            .where((item) => item['title'].toLowerCase().contains(searchTask))
            .toList();
    return matchedItems;
  }

  List<Map<String, dynamic>> getSearchedEventsList() {
    if (searchText == '') return events;

    final searchTask = searchText.toLowerCase();

    List<Map<String, dynamic>> matchedItems =
        events.where((event) {
          final items = event['items'] as List<dynamic>;
          return items.any(
            (item) =>
                (item['title'] as String).toLowerCase().contains(searchTask),
          );
        }).toList();

    return matchedItems;
  }

  List<Map<String, dynamic>> getSearchedMilestonesList() {
    if (searchText == '') return milestones;

    final searchTask = searchText.toLowerCase();

    List<Map<String, dynamic>> matchedItems =
        milestones
            .where((item) => item['title'].toLowerCase().contains(searchTask))
            .toList();
    return matchedItems;
  }

  bool addTask(
    int uniqueKey,
    DateTime selectedDate,
    String title,
    String subTitle,
    String priority,
    List<Map<String, dynamic>> checkList,
  ) {
    if (title.isEmpty || subTitle.isEmpty || title == '' || subTitle == '') {
      return false;
    }

    Map<String, dynamic> newTask = {
      'todo_id': uniqueKey,
      'date': selectedDate,
      'month': DateFormat.MMM().format(selectedDate),
      'title': title,
      'subTitle': subTitle,
      'types': 'Todo',
      'priority': priority,
      'percentCompleted': double.parse(0.0.toStringAsFixed(2)),
      'checks': checkList,
    };

    todoTasks.add(newTask);
    notifyListeners();
    return true;
  }

  void addEventsItems(String typeOfEvent, Map<String, dynamic> items) {
    final selectedEvent = events.firstWhere(
      (event) => event['type'] == typeOfEvent,
    );

    print('selected Event = $selectedEvent');

    selectedEvent['items'].add(items);
    notifyListeners();
  }

  void addMilestones(
    int uniqueKey,
    String title,
    DateTime selectedDate,
    String description,
    String priority,
  ) {
    final newMilestones = {
      'milestone_id': uniqueKey,
      'types': 'Milestone',
      'due_date': selectedDate,
      'month': DateFormat.MMM().format(selectedDate),
      'title': title,
      'description': description,
      'priority': priority,
      'isCompleted': false,
    };

    milestones.add(newMilestones);
    notifyListeners();
  }

  void removeProduct(int index) {
    todoTasks.removeAt(index);
    //It returns true if the value is available and removed successfully else false
    notifyListeners();
  }

  void updatePercentageCompleted(Map<String, dynamic> todo, double percent) {
    final currentTask = todoTasks.firstWhere(
      (task) => task['todo_id'] == todo['todo_id'],
    );

    currentTask['percentCompleted'] = percent;
    notifyListeners();
  }

  void addCheckListOfTodo(Map<String, dynamic> todo, String checkTitle) {
    final currentTodo = todoTasks.firstWhere(
      (task) => task['todo_id'] == todo['todo_id'],
    );
    print('CURRENT TODO = $currentTodo');
    final check = {'checkTitle': checkTitle, 'isCompleted': false};
    currentTodo['checks'].add(check);
    //It returns true if the value is available and removed successfully else false
    notifyListeners();
  }

  void removeCheckList(Map<String, dynamic> todo, int index) {
    final currentTodo = todoTasks.firstWhere(
      (task) => task['todo_id'] == todo['todo_id'],
    );

    List<Map<String, dynamic>> checkLists = currentTodo['checks'];
    checkLists.removeAt(index);
    notifyListeners();
  }

  void changeCheckListIsCompleted(Map<String, dynamic> todo, int index) {
    final currentTodo = todoTasks.firstWhere(
      (task) => task['todo_id'] == todo['todo_id'],
    );

    Map<String, dynamic> currentCheckLists = currentTodo['checks'][index];
    currentCheckLists['isCompleted'] = !currentCheckLists['isCompleted'];
    notifyListeners();
  }

  void changeMilestoneIsCompleted(Map<String, dynamic> milestone) {
    final currentMilestone = milestones.firstWhere(
      (task) => task['milestone_id'] == milestone['milestone_id'],
    );

    currentMilestone['isCompleted'] = !currentMilestone['isCompleted'];
  }

  void changeSearchText(String newText) {
    searchText = newText;
    notifyListeners();
  }

  void trueShowHistory() {
    showHistory = true;
    notifyListeners();
  }

  void falseShowHistory() {
    showHistory = false;
    notifyListeners();
  }

  void changeAddMore(bool value) {
    addMoreTodo = value;
    notifyListeners();
  }

  void calculateTotalEvents() {
    totalEvents = events.fold(0, (sum, eventMap) {
      final eventList = eventMap['items'] as List;
      return sum + eventList.length;
    });
    notifyListeners();
  }

  void calculateTotalTodos() {
    totalTodos = todoTasks.length;
    notifyListeners();
  }

  void calculateTotalMilestones() {
    totalMilestones = milestones.length;
    notifyListeners();
  }
}
