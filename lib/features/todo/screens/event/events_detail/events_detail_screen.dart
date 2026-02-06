import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:taskify/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_function.dart';

class EventsDetailScreen extends StatefulWidget {
  const EventsDetailScreen({
    super.key,
    required this.event,
    required this.eventType,
  });

  final Map<String, dynamic> event;
  final String eventType;

  @override
  State<EventsDetailScreen> createState() => _EventsDetailScreenState();
}

class _EventsDetailScreenState extends State<EventsDetailScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController withWhomController = TextEditingController();
  TextEditingController eventTypeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isEdit = false;
  bool isEditPerson = false;
  bool isEditReason = false;
  bool isDay = false;
  bool isNight = false;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event['title'];
    if (widget.eventType == 'Meeting') {
      withWhomController.text = widget.event['withWhom'];
      reasonController.text =
          widget.event['reason'] != null || widget.event['reason'] != ''
              ? widget.event['reason']
              : '';
    } else if (widget.eventType == 'Custom') {
      eventTypeController.text = widget.event['event_type'];
    } else if (widget.eventType == 'Wedding') {
      eventTypeController.text = widget.event['time'];
    }
    dateController.text =
        '${widget.event['date'].day}/${widget.event['date'].month}/${widget.event['date'].year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text(widget.eventType)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ASizes.defaultSpace),
          child: SizedBox(
            height: AHelperFunctions.screenHeight(context) / 1.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: AHelperFunctions.screenWidth(context) * 0.9,
                    padding: EdgeInsets.all(ASizes.defaultSpace / 2),
                    decoration: BoxDecoration(
                      color: AColors.primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        isEdit
                            ? Row(
                              children: [
                                Flexible(
                                  flex: 7,
                                  child: TextFormField(
                                    controller: titleController,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      label: Text(
                                        'Title',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onTapOutside:
                                        (_) => FocusScope.of(context).unfocus(),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed:
                                          () => setState(() {
                                            widget.event['title'] =
                                                titleController.text;
                                            isEdit = false;
                                          }),
                                      icon: Icon(
                                        Iconsax.tick_circle,
                                        color: Colors.white,
                                      ),
                                      iconSize: 25,
                                    ),
                                    IconButton(
                                      onPressed:
                                          () => setState(() {
                                            titleController.text =
                                                widget.event['title'];
                                            isEdit = false;
                                          }),
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.white,
                                      ),
                                      iconSize: 25,
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  titleController.text,
                                  style: TextStyle(
                                    fontSize: 20,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      () => setState(() {
                                        isEdit = true;
                                      }),
                                  icon: Icon(Iconsax.edit_2),
                                  iconSize: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                        SizedBox(height: ASizes.spaceBtwItems),
                        widget.eventType == 'Meeting'
                            ? Row(
                              children: [
                                Text(
                                  'With Whom: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                isEditPerson
                                    ? Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              controller: withWhomController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  widget.event['withWhom'] =
                                                      withWhomController.text;
                                                  setState(() {
                                                    isEditPerson = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Iconsax.tick_circle,
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  withWhomController.text =
                                                      widget.event['withWhom'];
                                                  setState(() {
                                                    isEditPerson = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                    : Row(
                                      children: [
                                        Text(
                                          widget.event['withWhom'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditPerson = true;
                                            });
                                          },
                                          icon: Icon(
                                            Iconsax.edit_2,
                                            color: Colors.white,
                                          ),
                                          iconSize: 15,
                                        ),
                                      ],
                                    ),
                              ],
                            )
                            : widget.eventType == 'Wedding'
                            ? Row(
                              children: [
                                Text(
                                  'Wedding Time: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Flexible(
                                  child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: VisualDensity(
                                      horizontal:
                                          VisualDensity
                                              .minimumDensity, // Reduces horizontal spacing
                                      vertical:
                                          VisualDensity
                                              .minimumDensity, // Reduces vertical spacing
                                    ),
                                    title: Text(
                                      'Day',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    value: 'Day',
                                    groupValue: widget.event['time'],
                                    onChanged: (String? value) {
                                      widget.event['time'] = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: RadioListTile<String>(
                                    contentPadding: EdgeInsets.zero,
                                    visualDensity: VisualDensity(
                                      horizontal:
                                          VisualDensity
                                              .minimumDensity, // Reduces horizontal spacing
                                      vertical:
                                          VisualDensity
                                              .minimumDensity, // Reduces vertical spacing
                                    ),
                                    title: Text(
                                      'Night',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    value: 'Night',
                                    groupValue: widget.event['time'],
                                    onChanged: (String? value) {
                                      widget.event['time'] = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            )
                            : widget.eventType == 'Custom'
                            ? Row(
                              children: [
                                Text(
                                  'Event Type: ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                isEditPerson
                                    ? Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              controller: eventTypeController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  widget.event['event_type'] =
                                                      eventTypeController.text;
                                                  setState(() {
                                                    isEditPerson = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Iconsax.tick_circle,
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  eventTypeController.text =
                                                      widget
                                                          .event['event_type'];
                                                  setState(() {
                                                    isEditPerson = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                    : Row(
                                      children: [
                                        Text(
                                          widget.event['event_type'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isEditPerson = true;
                                            });
                                          },
                                          icon: Icon(
                                            Iconsax.edit_2,
                                            color: Colors.white,
                                          ),
                                          iconSize: 15,
                                        ),
                                      ],
                                    ),
                              ],
                            )
                            : SizedBox(),

                        SizedBox(height: ASizes.spaceBtwItems),
                        widget.eventType == 'Meeting'
                            ? Row(
                              children: [
                                Text(
                                  'Reason:  ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                isEditReason
                                    ? Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: TextFormField(
                                              controller: reasonController,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                              maxLines: 5,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  widget.event['reason'] =
                                                      reasonController.text;
                                                  setState(() {
                                                    isEditReason = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Iconsax.tick_circle,
                                                  color: Colors.greenAccent,
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  reasonController.text =
                                                      widget.event['reason'];
                                                  setState(() {
                                                    isEditReason = false;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.cancel_outlined,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                    : Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: ReadMoreText(
                                              widget.event['reason'],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                              trimMode: TrimMode.Line,
                                              trimLines: 5,
                                              trimCollapsedText: ' Read More',
                                              trimExpandedText: ' Read Less',
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isEditReason = true;
                                              });
                                            },
                                            icon: Icon(
                                              Iconsax.edit_2,
                                              color: Colors.white,
                                            ),
                                            iconSize: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                              ],
                            )
                            : SizedBox(),
                        SizedBox(height: ASizes.spaceBtwItems),
                        Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                controller: dateController,
                                onTap: () async {
                                  selectedDate =
                                      await AHelperFunctions.selectDate(
                                        context,
                                        selectedDate,
                                      );
                                  if (selectedDate != null) {
                                    dateController.text =
                                        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                                    widget.event['date'] = selectedDate;
                                    widget.event['month'] = DateFormat.MMM()
                                        .format(selectedDate!);
                                  }
                                },
                                decoration: InputDecoration(
                                  label: Text(
                                    'Due Date',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onTapOutside:
                                    (_) => FocusScope.of(context).unfocus(),
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () async {
                                selectedDate =
                                    await AHelperFunctions.selectDate(
                                      context,
                                      selectedDate,
                                    );
                                if (selectedDate != null) {
                                  dateController.text =
                                      '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                                  widget.event['date'] = selectedDate;
                                  widget.event['month'] = DateFormat.MMM()
                                      .format(selectedDate!);
                                }
                              },
                              child: Text(
                                'Select Date',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
