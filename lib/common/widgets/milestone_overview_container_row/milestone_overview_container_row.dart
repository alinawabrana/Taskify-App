import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MilestoneOverviewContainerRow extends StatelessWidget {
  const MilestoneOverviewContainerRow({super.key, required this.milestone});

  final Map<String, dynamic> milestone;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(
          context,
        ).push('/milestones_detail', extra: {'milestone': milestone});
      },
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50,
                width: 5,
                color:
                    milestone['priority'] == 'High'
                        ? Colors.redAccent
                        : milestone['priority'] == 'Medium'
                        ? Colors.blueAccent
                        : Colors.greenAccent,
              ),
              SizedBox(
                width: 40,
                height: 50,
                child: Column(
                  children: [
                    Text(
                      milestone['month'],
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Text(
                      milestone['due_date'].day.toString(),
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
              Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      milestone['title'],
                      style: Theme.of(context).textTheme.titleSmall!.apply(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Text(
                milestone['isCompleted'] ? 'Completed' : 'Not\nCompleted',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
