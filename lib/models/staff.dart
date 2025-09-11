// models/staff.dart
import 'package:hive/hive.dart';

part 'staff.g.dart';

@HiveType(typeId: 9)
class Staff extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String fullname;

  Staff({
    required this.username,
    required this.password,
    required this.fullname,
  });
}
