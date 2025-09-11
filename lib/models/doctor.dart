// models/doctor.dart
import 'package:hive/hive.dart';

part 'doctor.g.dart';

@HiveType(typeId: 6)
class Doctor extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String fullname;

  @HiveField(3)
  String specialty;

  Doctor({
    required this.username,
    required this.password,
    required this.fullname,
    required this.specialty,
  });
}
