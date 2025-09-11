// pages/customer_signup_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/customer.dart';
import 'customer_home_page.dart';


class CustomerSignUpPage extends StatefulWidget {
  const CustomerSignUpPage({super.key});

  @override
  State<CustomerSignUpPage> createState() => _CustomerSignUpPageState();
}

class _CustomerSignUpPageState extends State<CustomerSignUpPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> _signup() async {
    var box = Hive.box<Customer>('customers');
    var newCustomer = Customer(
      username: _userController.text,
      password: _passController.text,
      name: _nameController.text,
    );

  await box.add(newCustomer);

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ثبت‌نام با موفقیت انجام شد')));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => CustomerHomePage(customer: newCustomer)),
      );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ثبت‌نام مشتری')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'نام کامل')),
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'نام کاربری')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'رمز عبور'), obscureText: true),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: _signup, child: const Text('ثبت‌نام')),
          ],
        ),
      ),
    );
  }
}
