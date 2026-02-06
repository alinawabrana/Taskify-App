import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/common/widgets/todo_overview_container_row/todo_overview_container_row.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(taskProvider).todoTasks;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text('Todo'),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 20, height: 20, color: Colors.redAccent),
              SizedBox(height: 2),
              Text('High', style: TextStyle(fontSize: 10)),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 20, height: 20, color: Colors.blueAccent),
              SizedBox(height: 2),
              Text('Medium', style: TextStyle(fontSize: 10)),
            ],
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 20, height: 20, color: Colors.greenAccent),
              SizedBox(height: 2),
              Text('Low', style: TextStyle(fontSize: 10)),
            ],
          ),
          SizedBox(width: 30),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Expanded(
          child: ListView.builder(
            itemCount: todo.length,
            itemBuilder: (context, index) {
              final task = todo[index];
              double percent = task['percentCompleted'];
              return TodoOverviewContainerRow(task: task, percent: percent);
            },
          ),
        ),
      ),
    );
  }
}
