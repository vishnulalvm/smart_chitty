import 'package:hive_flutter/hive_flutter.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 6)
class ReminderModel {
  @HiveField(0)
  final String reminderNote;

  @HiveField(1)
  final String reminderDate;

  @HiveField(2)
  final String reminderTime;

  @HiveField(3)
  final DateTime now;

  @HiveField(4)
  bool? isChecked;

  ReminderModel(
      {required this.isChecked,
      required this.reminderNote,
      required this.reminderDate,
      required this.reminderTime,
      required this.now});

      
}
