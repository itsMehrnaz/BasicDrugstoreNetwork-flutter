// pages/cart_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final Map<int, int> cart;
  const CartPage({super.key, required this.cart});
  // پارامتر کی رو از کلاس والد مسنقیم به خود والد بده تا فلاتر بفهمه که ایا این صفحه هم.ن صفحه قبلیه یا باید دوباره ساخته  بشه

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get total {
    double sum = 0;
    var box = Hive.box<Product>('products');
    widget.cart.forEach((i, qty) {
      var p = box.getAt(i)!;
      sum += p.discount * qty;
    });
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Product>('products');
    return Scaffold(
      appBar: AppBar(title: const Text('سبد خرید')),
      body: ListView(
        children: [
          ...widget.cart.entries.map((entry) {//////////////////////////
            var p = box.getAt(entry.key)!;
            return ListTile(
              title: Text(p.name),
              subtitle: Text('تعداد: ${entry.value}'),
              trailing: Text('قیمت: ${p.discount * entry.value}'),
            );
          }),
          const Divider(),
          ListTile(
            title: const Text('جمع کل'),
            trailing: Text('$total تومان'),
          ),
        ],
      ),
    );
  }
}
