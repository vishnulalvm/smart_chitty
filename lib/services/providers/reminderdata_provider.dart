import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:smart_chitty/services/models/reminder_model.dart';

class ReminderListProvider extends ChangeNotifier {
  List<ReminderModel> reminders = [];
  List<ReminderModel> sortedReminders = [];
  List<ReminderModel> lastFourReminders = [];

  Future<void> getReminders() async {
    sortedReminders.clear();
    lastFourReminders.clear();
    final box = await Hive.openBox<ReminderModel>('reminders');
    final reminderdata = box.values.toList();
    reminders = reminderdata;
    if (reminderdata.isNotEmpty) {
      reminders.sort((a, b) {
        final aDate = a.now;
        final bDate = b.now;
        return bDate.compareTo(aDate);
      });
      sortedReminders.addAll(reminders);

      final today = DateFormat('dd-MM-yyyy').format(DateTime.now());
      sortedReminders.removeWhere((reminder) => reminder.reminderDate == today);

      lastFourReminders = sortedReminders.take(4).toList();
      // lastFourReminders = lastFourReminderss;
    }
    notifyListeners();
  }

  Future<void> deleteReminder(int index) async {
    final box = await Hive.openBox<ReminderModel>('reminders');
    final reminderToDelete = reminders[index];
    await box.deleteAt(index);
    reminders.removeAt(index);
    int lastFourRemindersIndex = lastFourReminders.indexOf(reminderToDelete);
    if (lastFourRemindersIndex != -1) {
    lastFourReminders.removeAt(lastFourRemindersIndex);
  }
    notifyListeners();
  }
}
