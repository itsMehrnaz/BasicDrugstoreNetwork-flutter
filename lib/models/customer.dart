// models/customer.dart
import 'package:hive/hive.dart';

part 'customer.g.dart';

@HiveType(typeId: 5)
class Customer extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String name;

  Customer({
    required this.username,
    required this.password,
    required this.name,
  });
}
