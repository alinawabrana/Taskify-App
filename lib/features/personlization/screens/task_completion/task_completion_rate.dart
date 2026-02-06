import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class TaskCompletionRate extends ConsumerWidget {
  const TaskCompletionRate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskWatch = ref.watch(taskProvider);

    final todo = taskWatch.todoTasks;
    final milestones = taskWatch.milestones;

    final totalTodo = todo.length;
    final totalMilestones = milestones.length;

    final completedTodo =
        todo.where((task) => task['percentCompleted'] == 1.0).length;
    final completedMilestones =
        milestones.where((task) => task['isCompleted'] == true).length;

    final dataMap = <String, double>{
      "Todo": completedTodo / (totalTodo + totalMilestones),
      "Milestones": completedMilestones / (totalTodo + totalMilestones),
    };

    final colorList = <Color>[Colors.blue, Colors.green];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Task Completion Rate",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AColors.primaryColor,
      ),
      body: Center(
        child: SizedBox(
          width: AHelperFunctions.screenWidth(context) * 0.9,
          height: AHelperFunctions.screenHeight(context) * 0.35,
          child: Card(
            color: AColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  PieChart(
                    dataMap: dataMap,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 2.7,
                    colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.disc,
                    ringStrokeWidth: 32,
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                  ),
                  SizedBox(height: ASizes.spaceBtwSections),
                  Row(
                    children: [
                      Text(
                        'Todo tasks completed:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$completedTodo/$totalTodo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Row(
                    children: [
                      Text(
                        'Milestones completed:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '$completedMilestones/$totalMilestones',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
