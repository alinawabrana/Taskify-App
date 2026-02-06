import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/common/widgets/event_overview_container_row/event_overview_container_row.dart';
import 'package:taskify/provider.dart';

import '../../../../utils/constants/sizes.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.eventType});

  final String eventType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events =
        ref
            .watch(taskProvider)
            .events
            .where((event) {
              print('event type: ${event['type']}');
              return event['type'] == eventType;
            })
            .toList()
            .first;
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text('$eventType events')),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Expanded(
          child: ListView.builder(
            itemCount: events['items'].length,
            itemBuilder: (context, index) {
              final event = events['items'][index];
              return EventOverviewContainerRow(
                eventType: eventType,
                item: event,
              );
            },
          ),
        ),
      ),
    );
  }
}
