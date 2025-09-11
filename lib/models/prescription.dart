// models/prescription.dart
import 'package:hive/hive.dart';

part 'prescription.g.dart';

@HiveType(typeId: 7)
class Prescription extends HiveObject {
  @HiveField(0)
  String patientName;

  @HiveField(1)
  String doctorName;

  @HiveField(2)
  String specialty;

  @HiveField(3)
  List<String> medicines;

  @HiveField(4)
  bool isCompleted;

  Prescription({
    required this.patientName,
    required this.doctorName,
    required this.specialty,
    required this.medicines,
    this.isCompleted = false,
  });
}
