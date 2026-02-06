import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:taskify/common/widgets/overlay_dropdown/overlay_dropdown_priority.dart';
import 'package:taskify/provider.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';

class MilestonesDetailsScreen extends ConsumerStatefulWidget {
  const MilestonesDetailsScreen({super.key, required this.milestone});

  final Map<String, dynamic> milestone;

  @override
  ConsumerState<MilestonesDetailsScreen> createState() =>
      _MilestonesDetailsScreenState();
}

class _MilestonesDetailsScreenState
    extends ConsumerState<MilestonesDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
  bool isEditDes = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.milestone['title'];
    dateController.text =
        '${widget.milestone['due_date'].day}/${widget.milestone['due_date'].month}/${widget.milestone['due_date'].year}';
    descriptionController.text =
        (widget.milestone['description'] != null ||
                widget.milestone['description'] != '')
            ? widget.milestone['description']
            : '';
  }

  @override
  Widget build(BuildContext context) {
    final milestoneWatch = ref.watch(taskProvider);
    final milestoneRead = ref.read(taskProvider);
    DateTime? selectedDate;
    LayerLink _priorityLink = LayerLink();

    final List<Map<String, dynamic>> priorities = [
      {'priority': 'Low'},
      {'priority': 'Medium'},
      {'priority': 'High'},
    ];

    Future<void> selectDate(BuildContext context) async {
      selectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        helpText: 'Select a date',
        confirmText: 'Confirm',
        cancelText: 'Cancel',
      );

      if (selectedDate != null) {
        dateController.text =
            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
        widget.milestone['due_date'] = selectedDate;
        widget.milestone['month'] = DateFormat.MMM().format(selectedDate!);
      }
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text('Milestone Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ASizes.defaultSpace),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ASizes.spaceBtwItems),
                isEdit
                    ? Row(
                      children: [
                        Flexible(
                          flex: 7,
                          child: TextFormField(
                            controller: titleController,
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(label: Text('Title')),
                            onTapOutside:
                                (_) => FocusScope.of(context).unfocus(),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed:
                                  () => setState(() {
                                    widget.milestone['title'] =
                                        titleController.text;
                                    isEdit = false;
                                  }),
                              icon: Icon(Iconsax.tick_circle),
                              iconSize: 25,
                            ),
                            IconButton(
                              onPressed:
                                  () => setState(() {
                                    titleController.text =
                                        widget.milestone['title'];
                                    isEdit = false;
                                  }),
                              icon: Icon(Icons.cancel_outlined),
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
                          ),
                        ),
                        IconButton(
                          onPressed:
                              () => setState(() {
                                isEdit = true;
                              }),
                          icon: Icon(Iconsax.edit_2),
                          iconSize: 20,
                        ),
                      ],
                    ),
                SizedBox(height: ASizes.spaceBtwItems),
                Container(
                  width: AHelperFunctions.screenWidth(context) * 0.9,
                  padding: EdgeInsets.all(ASizes.defaultSpace / 2),
                  decoration: BoxDecoration(
                    color: AColors.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: widget.milestone['isCompleted'],
                            onChanged: (value) {
                              milestoneRead.changeMilestoneIsCompleted(
                                widget.milestone,
                              );
                              setState(() {});
                            },
                            side: BorderSide(color: Colors.white),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Is Completed',
                            style: TextStyle(color: Colors.white),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                'Priority:',
                                style: TextStyle(color: Colors.white),
                              ),
                              OverlayDropdownPriority(
                                linkLayer: _priorityLink,
                                options: priorities,
                                todo: widget.milestone,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: ASizes.spaceBtwItems),
                      isEditDes
                          ? Column(
                            children: [
                              TextFormField(
                                controller: descriptionController,
                                maxLines: 6,
                                decoration: InputDecoration(
                                  label: Text(
                                    'Description',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                style: TextStyle(color: Colors.white),
                                onTapOutside:
                                    (_) => FocusScope.of(context).unfocus(),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(
                                    onPressed: () {
                                      widget.milestone['description'] =
                                          descriptionController.text;
                                      setState(() {
                                        isEditDes = false;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    child: Text(
                                      'Save',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  OutlinedButton(
                                    onPressed: () {
                                      descriptionController.text =
                                          widget.milestone['description'];
                                      setState(() {
                                        isEditDes = false;
                                      });
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Description',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isEditDes = true;
                                      });
                                    },
                                    icon: Icon(
                                      Iconsax.edit_2,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ASizes.spaceBtwItems / 2),
                              ReadMoreText(
                                (widget.milestone['description'] != null ||
                                        widget.milestone['description'] == '')
                                    ? widget.milestone['description']
                                    : '',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                trimMode: TrimMode.Line,
                                trimLines: 5,
                                trimCollapsedText: ' Read More',
                                trimExpandedText: ' Read Less',
                              ),
                            ],
                          ),
                      SizedBox(height: ASizes.spaceBtwSections),
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
                                  widget.milestone['due_date'] = selectedDate;
                                  widget.milestone['month'] = DateFormat.MMM()
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
                              selectedDate = await AHelperFunctions.selectDate(
                                context,
                                selectedDate,
                              );
                              if (selectedDate != null) {
                                dateController.text =
                                    '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                                widget.milestone['due_date'] = selectedDate;
                                widget.milestone['month'] = DateFormat.MMM()
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
    );
  }
}
