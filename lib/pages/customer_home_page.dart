// pages/customer_home_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/customer.dart';
import '../models/product.dart';
import 'cart_page.dart';

class CustomerHomePage extends StatefulWidget {
  final Customer customer;
  const CustomerHomePage({super.key, required this.customer});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  final Map<int, int> cart = {};

  void _addToCart(int index) {
    setState(() {
      cart[index] = (cart[index] ?? 0) + 1;
    });
  }

  void _goToCart() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => CartPage(cart: cart),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Product>('products');
    return Scaffold(
      appBar: AppBar(
        title: Text('خوش آمدید ${widget.customer.name}'),
        actions: [
          IconButton(onPressed: _goToCart, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Product> box, _) {
          if (box.values.isEmpty) return const Center(child: Text('محصولی وجود ندارد'));
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, i) {
              var product = box.getAt(i)!;
              return ListTile(
                leading: const Icon(Icons.medication),
                title: Text('${product.name} (${product.volume})'),
                subtitle: Text('قیمت: ${product.discount} (با تخفیف:${product.price})'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () => _addToCart(i),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
