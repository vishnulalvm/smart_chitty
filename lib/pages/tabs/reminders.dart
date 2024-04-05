import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_chitty/pages/others/Reminder_features/set_reminder.dart';
import 'package:smart_chitty/services/providers/reminderdata_provider.dart';
import 'package:smart_chitty/utils/colors.dart';
import 'package:smart_chitty/utils/text.dart';
import 'package:smart_chitty/widgets/global/appbar.dart';
import 'package:smart_chitty/widgets/global/widget_gap.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool gridview = true;
  bool isChecked = false;
  final reminderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: customAppBar(
        title: 'Reminders',
        showMenu: false,
        onpresed: (onpresed) {},
      ),
      body: Consumer<ReminderListProvider>(
          builder: (context, reminderdata, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Reminders : ${reminderdata.sortedReminders.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          gridview == true ? gridview = false : gridview = true;
                        });
                      },
                      icon: gridview == true
                          ? const Icon(
                              Icons.grid_3x3,
                              size: 25,
                            )
                          : const Icon(
                              Icons.list,
                              size: 25,
                            )),
                ],
              ),
            ),
            Expanded(
                child: gridview
                    ? ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          final reminder = reminderdata.reminders[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(children: <Widget>[
                              const Expanded(
                                  child: Divider(
                                thickness: 1,
                                endIndent: 12,
                                indent: 12,
                                color: Colors.blue,
                              )),
                              Text(reminder.reminderDate),
                              const Expanded(
                                  child: Divider(
                                endIndent: 12,
                                indent: 12,
                                thickness: 1,
                                color: Colors.blue,
                              )),
                            ]),
                          );
                        },
                        itemCount: reminderdata.reminders.length,
                        itemBuilder: (BuildContext context, int index) {
                          final reminder = reminderdata.reminders[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 12, left: 12, right: 12),
                            child: Container(
                              width: double.maxFinite,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(28, 167, 190, 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        reminderdata.deleteReminder(index);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: reminderdata.reminders.length,
                          itemBuilder: (context, index) {
                            final data = reminderdata.reminders[index];
                            return Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20)),
                                color: Color.fromRGBO(28, 167, 190, 1),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RichText(
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: data.reminderNote,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        ModifiedText(
                                            text: data.reminderDate,
                                            size: 14,
                                            color: Colors.white),
                                        gap(width: 10),
                                        ModifiedText(
                                            text: data.reminderTime,
                                            size: 14,
                                            color: Colors.white)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
          ],
        );
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
