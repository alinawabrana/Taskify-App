import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:taskify/common/widgets/text_form_field/primary_text_form_field.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../provider.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class NewMilestonesScreen extends ConsumerStatefulWidget {
  const NewMilestonesScreen({super.key});

  @override
  ConsumerState<NewMilestonesScreen> createState() =>
      _NewMilestonesScreenState();
}

class _NewMilestonesScreenState extends ConsumerState<NewMilestonesScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime? selectedDate = DateTime.now();
  String priority = 'High';
  int uniqueKey = 5;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text =
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('New Milestones', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: SizedBox(
          width: AHelperFunctions.screenWidth(context) * 0.9,
          height: AHelperFunctions.screenHeight(context) * 0.6,
          child: Card(
            color: AColors.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(ASizes.defaultSpace),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
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
                    ],
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  PrimaryTextFormField(
                    label: 'Title *',
                    controller: titleController,
                  ),
                  SizedBox(height: ASizes.spaceBtwItems),
                  PrimaryTextFormField(
                    label: 'Description',
                    controller: descriptionController,
                    maxLines: 5,
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
                            .addMilestones(
                              uniqueKey,
                              titleController.text,
                              selectedDate!,
                              descriptionController.text,
                              priority,
                            );
                        context.pop();
                      },
                      child: Text(
                        'Add New Event',
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
