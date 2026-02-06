import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/common/widgets/milestone_overview_container_row/milestone_overview_container_row.dart';
import 'package:taskify/provider.dart';

import '../../../../utils/constants/sizes.dart';

class MilestoneScreen extends ConsumerWidget {
  const MilestoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final milestones = ref.watch(taskProvider).milestones;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text('Milestones')),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Expanded(
          child: ListView.builder(
            itemCount: milestones.length,
            itemBuilder: (context, index) {
              final milestone = milestones[index];
              return MilestoneOverviewContainerRow(milestone: milestone);
            },
          ),
        ),
      ),
    );
  }
}
