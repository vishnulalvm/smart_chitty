import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/services/models/reminder_model.dart';
import 'package:smart_chitty/services/providers/reminderdata_provider.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/features/custom_textfield.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final formKey = GlobalKey<FormState>();
  BuildContext? _context;
  @override
  void initState() {
    super.initState();
    _context = context;
  }

  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  final reminderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
        title: 'Set Reminder',
        onpresed: (onpresed) {},
        showMenu: false,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 12, right: 12, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    customTextField(
                        context: context,
                        maxline: 3,
                        hintText: 'Reminder Note',
                        title: 'Reminder Note :',
                        keyboardType: TextInputType.multiline,
                        validator: (value) =>
                            value!.isEmpty ? 'Type New Reminder' : null,
                        controller: reminderController),
                    gap(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ModifiedText(
                          text: 'Select Date :',
                          size: 14,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        gap(width: 45),
                        SizedBox(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                            ),
                            onPressed: () => _selectDate(context),
                            child: ModifiedText(
                              text: _selectedDate == null
                                  ? 'Select Date'
                                  : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                              size: 14,
                              color: AppColor.fontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    gap(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ModifiedText(
                          text: 'Select Time :',
                          size: 14,
                          color: AppColor.fontColor,
                          fontWeight: FontWeight.w500,
                        ),
                        gap(width: 45),
                        SizedBox(
                          width: 200,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                            ),
                            onPressed: () async {
                              final TimeOfDay? newTime = await showTimePicker(
                                context: context,
                                initialTime: _selectedTime ?? TimeOfDay.now(),
                              );
                              if (newTime != null) {
                                setState(() {
                                  _selectedTime = newTime;
                                });
                              }
                            },
                            child: ModifiedText(
                              text: _selectedTime != null
                                  ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                                  : 'Select Time',
                              size: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          extendedPadding: const EdgeInsets.only(left: 30, right: 30),
          label: const Text(
            'Add Reminder',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            weight: 800,
          ),
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Adjust radius as needed
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              saveSchemeToHive();
              final reminderModel =
                  Provider.of<ReminderListProvider>(context, listen: false);
              reminderModel.getReminders();
            }
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> saveSchemeToHive() async {
    try {
      final reminderNote = reminderController.text;
      final reminderDate = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      final reminderTime = _selectedTime!.format(context);
      final now = DateTime.now();
      final reminder = ReminderModel(
        isChecked: false,
        now: now,
        reminderDate: reminderDate,
        reminderNote: reminderNote,
        reminderTime: reminderTime,
      );
      final box = await Hive.openBox<ReminderModel>('reminders');
      await box.put(now.toString(), reminder);
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Scheme added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(_context!);
    } catch (error) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text('Failed to add member'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
