import 'package:hive/hive.dart';

part 'employee.g.dart';

@HiveType(typeId: 0)
class Employee extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String rule;

  @HiveField(3)
  DateTime joinDate;

  @HiveField(4)
  DateTime? endDate;

  @HiveField(5)
  bool active;
  
  @HiveField(6)
  int position;

  Employee({
    required this.id,
    required this.name,
    required this.joinDate,
    required this.rule,
    required this.position,
    this.endDate,
    this.active = true,
  });
}
