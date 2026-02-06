import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class EventOverviewContainerRow extends StatelessWidget {
  const EventOverviewContainerRow({
    super.key,
    required this.eventType,
    required this.item,
  });

  final String eventType;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final isDark = AHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Container(
          decoration:
              eventType == 'Birthday'
                  ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/background/birthday_background_3.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  )
                  : null,
          child: GestureDetector(
            onTap:
                () => GoRouter.of(context).push(
                  '/events_detail',
                  extra: {'event': item, 'eventType': eventType},
                ),
            child: Row(
              children: [
                SizedBox(
                  width: 40,
                  height: 50,
                  child: Column(
                    children: [
                      Text(
                        item['month'],
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(
                          color:
                              eventType == 'Birthday'
                                  ? Colors.black
                                  : isDark
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Text(
                        item['date'].day.toString(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        item['title'],
                        style: Theme.of(context).textTheme.titleSmall!.apply(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                (eventType == 'Meeting' || eventType == 'Wedding')
                    ? Text(
                      item['time'],
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}
