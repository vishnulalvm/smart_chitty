import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/other_screens/set_reminder.dart';
import 'package:smart_chitty/services/providers/reminderdata_provider.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool isChecked = false;

  // TimeOfDay? _selectedTime;
  // DateTime? _selectedDate;
  final reminderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
        title: 'Reminders',
        onpresed: (onpresed) {},
      ),
      body: Consumer<ReminderListProvider>(
          builder: (context, reminderdata, child) {
        return ListView.builder(
            // controller: scrollController,
            itemCount: reminderdata.reminders.length,
            itemBuilder: (BuildContext context, int index) {
              final reminder = reminderdata.reminders[index];
              // isChecked =reminder.isChecked;
              return Padding(
                padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(28, 167, 190, 1),
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 280,
                          child: RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text:
                                  '${reminder.reminderNote} @ ${reminder.reminderTime} ${reminder.reminderDate}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                decoration: isChecked
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                          ),
                        ),
                        IconButton(onPressed: (){
                         reminderdata.deleteReminder(index);
                        }, icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),)
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const SetReminderScreen()));
        },
        child: const Icon(
          Icons.add,
          weight: 800,
          color: Colors.white,
        ),
      ),
    );
  }
}
