import 'package:flutter/material.dart';
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
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;
  final reminderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(title: 'Set Reminder', onpresed: (onpresed) {}),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 12, right: 12),
        child: Column(
          children: [
            customTextField(
                hintText: 'Reminder',
                title: 'Reminder',
                keyboardType: TextInputType.multiline,
                validator: (value) =>
                    value!.isEmpty ? 'add no.of installment' : null,
                controller: reminderController),
            gap(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ModifiedText(
                  text: 'Proposed Start Date :',
                  size: 14,
                  color: AppColor.fontColor,
                  fontWeight: FontWeight.w500,
                ),
                gap(width: 57),
                Expanded(
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
                      size: 16,
                      color: AppColor.fontColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               
                ModifiedText(text: 'Select Time', size: 16, color: AppColor.fontColor,fontWeight: FontWeight.w500,),
                const SizedBox(width: 70),
                ElevatedButton(
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
                  child: ModifiedText(text:_selectedTime != null
                    ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
                    : 'Select Time' , size: 14, color: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
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
}
