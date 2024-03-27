import 'package:hive_flutter/hive_flutter.dart';
part 'monthly_collection_model.g.dart';
@HiveType(typeId: 5)
class MonthlyCollection {

  @HiveField(0)
  final String month;
  
  @HiveField(1)
  final double sales;

  MonthlyCollection({required this.month, required this.sales});
}
