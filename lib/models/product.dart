// models/product.dart
import 'package:hive/hive.dart';

part 'product.g.dart';

@HiveType(typeId: 8)
class Product extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  double discount;

  @HiveField(3)
  String image;

  @HiveField(4)
  String volume;

  @HiveField(5)
  int stock;

  Product({
    required this.name,
    required this.price,
    required this.discount,
    required this.image,
    required this.volume,
    required this.stock,
  });
}
