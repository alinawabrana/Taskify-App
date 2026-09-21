import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class TodoOverviewContainerRow extends StatelessWidget {
  const TodoOverviewContainerRow({
    super.key,
    required this.task,
    required this.percent,
  });

  final Map<String, dynamic> task;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: () {
          GoRouter.of(
            context,
          ).push('/todo_detail', extra: {'todo': task, 'percent': percent});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
              width: AHelperFunctions.screenWidth(context),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 5,
                    color:
                        task['priority'] == 'High'
                            ? Colors.redAccent
                            : task['priority'] == 'Medium'
                            ? Colors.blueAccent
                            : Colors.greenAccent,
                  ),
                  SizedBox(
                    width: 40,
                    height: 50,
                    child: Column(
                      children: [
                        Text(
                          task['month'],
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Text(
                          task['date'].day.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 245,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task['title'],
                          style: Theme.of(context).textTheme.titleSmall!.apply(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          task['subTitle'],
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Stack(
                    children: [
                      // Inside fill color
                      Container(
                        width: 28.5,
                        height: 28.5,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple, // Inner background color
                          shape: BoxShape.circle,
                        ),
                      ),

                      CircularPercentIndicator(
                        radius: 15.0,
                        backgroundColor: Colors.white,
                        percent: percent,
                        progressColor: Colors.blueAccent,
                        lineWidth: 3,
                        animation: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        center:
                            percent == 1.0
                                ? Icon(Iconsax.tick_circle, color: Colors.white)
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${percent * 100}',
                                      style: TextStyle(
                                        fontSize: 6.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "%",
                                      style: TextStyle(
                                        fontSize: 7.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
