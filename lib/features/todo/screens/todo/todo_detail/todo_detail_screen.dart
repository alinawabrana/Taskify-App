import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:readmore/readmore.dart';
import 'package:taskify/common/widgets/overlay_dropdown/overlay_dropdown.dart';
import 'package:taskify/common/widgets/overlay_dropdown/overlay_dropdown_priority.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class TodoDetailScreen extends ConsumerStatefulWidget {
  const TodoDetailScreen({
    super.key,
    required this.todo,
    required this.percent,
  });

  final Map<String, dynamic> todo;
  final double percent;

  @override
  ConsumerState<TodoDetailScreen> createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends ConsumerState<TodoDetailScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController checkTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isEdit = false;
  bool isEditDes = false;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo['title'];
    subTitleController.text =
        (widget.todo['subTitle'] != null || widget.todo['subTitle'] != '')
            ? widget.todo['subTitle']
            : '';
    dateController.text =
        '${widget.todo['date'].day}/${widget.todo['date'].month}/${widget.todo['date'].year}';
  }

  @override
  Widget build(BuildContext context) {
    final todoRiverPodWatch = ref.watch(taskProvider);
    final todoRiverPodRead = ref.read(taskProvider);
    final checkList = widget.todo['checks'];
    print('checks: $checkList');
    DateTime? selectedDate;

    LayerLink _priorityLink = LayerLink();

    final List<Map<String, dynamic>> priorities = [
      {'priority': 'Low'},
      {'priority': 'Medium'},
      {'priority': 'High'},
    ];

    return Scaffold(
      appBar: AppBar(toolbarHeight: 50, title: Text('Todo Detail')),
      body: Padding(
        padding: const EdgeInsets.all(ASizes.defaultSpace),
        child: Center(
          child: Column(
            children: [
              isEdit
                  ? Row(
                    children: [
                      Flexible(
                        flex: 7,
                        child: TextFormField(
                          controller: titleController,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(label: Text('Title')),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed:
                                () => setState(() {
                                  widget.todo['title'] = titleController.text;
                                  isEdit = false;
                                }),
                            icon: Icon(Iconsax.tick_circle),
                            iconSize: 25,
                          ),
                          IconButton(
                            onPressed:
                                () => setState(() {
                                  titleController.text = widget.todo['title'];
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
                        Flexible(
                          flex: 1,
                          child: LinearPercentIndicator(
                            percent: widget.todo['percentCompleted'],
                            leading: Text(
                              '${widget.todo['percentCompleted'] * 100}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Priority:',
                                style: TextStyle(color: Colors.white),
                              ),
                              OverlayDropdownPriority(
                                linkLayer: _priorityLink,
                                options: priorities,
                                todo: widget.todo,
                                onTap: () {
                                  setState(() {});
                                },
                                fontSize: 18,
                                iconSize: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 120,
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: checkList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final check = checkList[index];
                            return Row(
                              children: [
                                Checkbox(
                                  value: check['isCompleted'],
                                  side: const BorderSide(color: Colors.white70),
                                  onChanged: (value) {
                                    setState(() {});
                                    todoRiverPodRead.changeCheckListIsCompleted(
                                      widget.todo,
                                      index,
                                    );
                                    final percent =
                                        AHelperFunctions.calculateTodoTaskCompletionPerc(
                                          widget.todo,
                                        );
                                    todoRiverPodRead.updatePercentageCompleted(
                                      widget.todo,
                                      percent,
                                    );
                                  },
                                ),
                                Text(
                                  check['checkTitle'],
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                IconButton(
                                  onPressed: () {
                                    AHelperFunctions.showDeleteConfirmationDialog(
                                      context,
                                      () {
                                        todoRiverPodRead.removeCheckList(
                                          widget.todo,
                                          index,
                                        ); // Remove the item at this index
                                        final percent =
                                            AHelperFunctions.calculateTodoTaskCompletionPerc(
                                              widget.todo,
                                            );
                                        todoRiverPodRead
                                            .updatePercentageCompleted(
                                              widget.todo,
                                              percent,
                                            );
                                        setState(() {});
                                      },
                                      "Do you really want to delete this check list? This process cannot be undone.",
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete_outline,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Divider(),
                    SizedBox(height: ASizes.spaceBtwItems),
                    todoRiverPodWatch.addMoreTodo == false
                        ? OutlinedButton(
                          onPressed: () {
                            todoRiverPodRead.changeAddMore(true);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.blueAccent),
                            foregroundColor: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.add, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Add More',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        )
                        : Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: checkTitleController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  label: Text(
                                    'CheckBoxTitle....',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                ),
                                onTapOutside:
                                    (_) => FocusScope.of(context).unfocus(),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                todoRiverPodRead.addCheckListOfTodo(
                                  widget.todo,
                                  checkTitleController.text,
                                );
                                checkTitleController.text = '';
                                final percent =
                                    AHelperFunctions.calculateTodoTaskCompletionPerc(
                                      widget.todo,
                                    );
                                todoRiverPodRead.updatePercentageCompleted(
                                  widget.todo,
                                  percent,
                                );
                                todoRiverPodRead.changeAddMore(false);
                              },
                              icon: Icon(
                                Iconsax.tick_square,
                                color: Colors.greenAccent,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                checkTitleController.text = '';
                                todoRiverPodRead.changeAddMore(false);
                              },
                              icon: Icon(
                                Icons.cancel_outlined,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                    SizedBox(height: ASizes.spaceBtwItems),
                    isEditDes
                        ? Column(
                          children: [
                            TextFormField(
                              controller: subTitleController,
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
                                    widget.todo['subTitle'] =
                                        subTitleController.text;
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
                                    subTitleController.text =
                                        widget.todo['subTitle'];
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
                              (widget.todo['subTitle'] != null ||
                                      widget.todo['subTitle'] == '')
                                  ? widget.todo['subTitle']
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
                              selectedDate = await AHelperFunctions.selectDate(
                                context,
                                selectedDate,
                              );
                              if (selectedDate != null) {
                                dateController.text =
                                    '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                                widget.todo['date'] = selectedDate;
                                widget.todo['month'] = DateFormat.MMM().format(
                                  selectedDate!,
                                );
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
                              widget.todo['date'] = selectedDate;
                              widget.todo['month'] = DateFormat.MMM().format(
                                selectedDate!,
                              );
                            }
                          },
                          child: Text(
                            'Select Date',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ASizes.spaceBtwItems),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
