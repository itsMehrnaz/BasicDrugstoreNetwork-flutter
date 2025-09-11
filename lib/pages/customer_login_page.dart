// pages/customer_login_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/customer.dart';
import 'customer_home_page.dart';
import 'customer_signup_page.dart';

class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({super.key});

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _login() async {
    var box = Hive.box<Customer>('customers');
    var customer = box.values.firstWhere(
      (c) => c.username == _userController.text && c.password == _passController.text,
      orElse: () => Customer(username: '', password: '', name: ''),
    );
    if (customer.username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CustomerHomePage(customer: customer)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نام کاربری یا رمز اشتباه است')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود مشتری')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'نام کاربری')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'رمز عبور'), obscureText: true),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: _login, child: const Text('ورود')),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerSignUpPage())),
              child: const Text('ثبت نام'),
            )
          ],
        ),
      ),
    );
  }
}
