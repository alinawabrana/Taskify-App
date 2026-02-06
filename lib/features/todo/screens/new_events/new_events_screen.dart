import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:taskify/common/widgets/text_form_field/primary_text_form_field.dart';
import 'package:taskify/utils/constants/sizes.dart';
import 'package:taskify/utils/helpers/helper_function.dart';

import '../../../../provider.dart';
import '../../../../utils/constants/colors.dart';

class NewEventsScreen extends ConsumerStatefulWidget {
  const NewEventsScreen({super.key});

  @override
  ConsumerState<NewEventsScreen> createState() => _NewEventsScreenState();
}

class _NewEventsScreenState extends ConsumerState<NewEventsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController withWhomController = TextEditingController();
  TextEditingController customEventTypeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String type = 'Event';
  String typeOfEvent = 'Birthday';
  String timeOfDay = 'Day';

  DateTime? selectedDate = DateTime.now();
  Map<String, Object> items = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateController.text =
        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
  }

  @override
  void dispose() {
    titleController.dispose();
    withWhomController.dispose();
    customEventTypeController.dispose();
    reasonController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),

        title: Text('New Events', style: TextStyle(color: Colors.white)),
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
                      Text(
                        'Type of Event:',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: ASizes.spaceBtwItems),
                      DropdownButton<String>(
                        dropdownColor: AColors.dark,
                        value: typeOfEvent,
                        items:
                            ['Birthday', 'Meeting', 'Wedding', 'Custom'].map((
                              String value,
                            ) {
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
                            typeOfEvent = newValue;
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
                  typeOfEvent == 'Meeting'
                      ? PrimaryTextFormField(
                        label: 'With Whom *',
                        controller: withWhomController,
                      )
                      : typeOfEvent == 'Wedding'
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
                              groupValue: timeOfDay,
                              onChanged: (String? value) {
                                timeOfDay = value!;
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
                              groupValue: timeOfDay,
                              onChanged: (String? value) {
                                timeOfDay = value!;
                                setState(() {});
                              },
                            ),
                          ),
                        ],
                      )
                      : typeOfEvent == 'Custom'
                      ? PrimaryTextFormField(
                        label: 'Custom Event Type *',
                        controller: customEventTypeController,
                      )
                      : SizedBox(),
                  SizedBox(height: ASizes.spaceBtwItems),
                  typeOfEvent == 'Meeting'
                      ? Flexible(
                        child: TextFormField(
                          controller: reasonController,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            label: Text(
                              'Reason',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                      : SizedBox(),
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
                        typeOfEvent == 'Birthday'
                            ? items = {
                              'date': selectedDate!,
                              'month': DateFormat.MMM().format(selectedDate!),
                              'title': titleController.text,
                            }
                            : typeOfEvent == 'Meeting'
                            ? items = {
                              'date': selectedDate!,
                              'month': DateFormat.MMM().format(selectedDate!),
                              'time': DateFormat.jm().format(selectedDate!),
                              'title': titleController.text,
                              'withWhom': withWhomController.text,
                              'reason': reasonController.text,
                            }
                            : typeOfEvent == 'Wedding'
                            ? items = {
                              'date': selectedDate!,
                              'month': DateFormat.MMM().format(selectedDate!),
                              'time': timeOfDay,
                              'title': titleController.text,
                            }
                            : items = {
                              'date': selectedDate!,
                              'month': DateFormat.MMM().format(selectedDate!),
                              'event_type': customEventTypeController.text,
                              'title': titleController.text,
                            };

                        ref
                            .read(taskProvider)
                            .addEventsItems(typeOfEvent, items);
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
