import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:taskify/common/widgets/text_form_field/primary_text_form_field.dart';
import 'package:taskify/provider.dart';
import 'package:taskify/utils/constants/colors.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

class NewTodoScreen extends ConsumerStatefulWidget {
  const NewTodoScreen({super.key});

  @override
  ConsumerState<NewTodoScreen> createState() => _NewTodoScreenState();
}

class _NewTodoScreenState extends ConsumerState<NewTodoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subTitleController = TextEditingController();
  TextEditingController checkTitleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String priority = 'High';
  List<Map<String, dynamic>> checkList = [];
  bool addMoreTodo = false;
  String type = 'Todo';
  DateTime? selectedDate = DateTime.now();
  int uniqueKey = 4;

  @override
  void initState() {
    super.initState();
    dateController.text =
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    subTitleController.dispose();
    checkTitleController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('New Todo', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SizedBox(
          width: AHelperFunctions.screenWidth(context) * 0.9,
          height: AHelperFunctions.screenHeight(context) * 0.7,
          child: Card(
            color: AColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryTextFormField(
                    label: 'Title',
                    controller: titleController,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  PrimaryTextFormField(
                    label: 'SubTitle',
                    controller: subTitleController,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  Row(
                    children: [
                      Text('Priority:', style: TextStyle(color: Colors.white)),
                      SizedBox(width: ASizes.spaceBtwItems),
                      DropdownButton<String>(
                        dropdownColor: AColors.dark,
                        value: priority,
                        items:
                            ['High', 'Medium', 'Low'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    value,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyLarge!.apply(
                                      fontSizeFactor: 0.8,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            priority = newValue;
                            setState(() {});
                          }
                        },
                      ),
                      Spacer(),
                      Text('Type: ', style: TextStyle(color: Colors.white)),
                      SizedBox(width: ASizes.spaceBtwItems),
                      Text(type, style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  SizedBox(
                    height: 120,
                    child:
                        checkList.isNotEmpty
                            ? Expanded(
                              child: ListView.builder(
                                itemCount: checkList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final check = checkList[index];
                                  return Row(
                                    children: [
                                      Text(
                                        'Check Title: ${check['checkTitle']}',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          AHelperFunctions.showDeleteConfirmationDialog(
                                            context,
                                            () {
                                              checkList.removeAt(
                                                index,
                                              ); // Remove the item at this index
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
                            )
                            : SizedBox(),
                  ),
                  Divider(),
                  SizedBox(height: ASizes.spaceBtwItems),
                  addMoreTodo == false
                      ? OutlinedButton(
                        onPressed: () {
                          setState(() {
                            addMoreTodo = true;
                          });
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
                              'Add CheckList',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                      : Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: checkTitleController,
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
                              final newCheckList = {
                                'isCompleted': false,
                                'checkTitle': checkTitleController.text,
                              };
                              checkList.add(newCheckList);
                              checkTitleController.text = '';
                              addMoreTodo = false;
                              setState(() {});
                            },
                            icon: Icon(
                              Iconsax.tick_square,
                              color: Colors.greenAccent,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              checkTitleController.text = '';
                              addMoreTodo = false;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.redAccent,
                            ),
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
                            }
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            label: Text(
                              'Due Date',
                              style: TextStyle(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                          }
                          setState(() {});
                        },
                        child: Text(
                          'Select Date',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: AHelperFunctions.screenWidth(context),
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .read(taskProvider)
                            .addTask(
                              uniqueKey,
                              selectedDate!,
                              titleController.text,
                              subTitleController.text,
                              priority,
                              checkList,
                            );
                        uniqueKey++;
                        context.pop();
                      },
                      child: Text(
                        'Add New Todo',
                        style: TextStyle(color: Colors.white),
                      ),
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
