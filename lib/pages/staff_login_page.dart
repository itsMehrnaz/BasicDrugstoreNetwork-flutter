// pages/staff_login_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/staff.dart';
import 'staff_dashboard_page.dart';

class StaffLoginPage extends StatefulWidget {
  const StaffLoginPage({super.key});

  @override
  State<StaffLoginPage> createState() => _StaffLoginPageState();
}

class _StaffLoginPageState extends State<StaffLoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _login() async {
    var box = Hive.box<Staff>('staff');
    var staff = box.values.firstWhere(
      (s) => s.username == _userController.text && s.password == _passController.text,
      orElse: () => Staff(username: '', password: '', fullname: ''),
    );
    if (staff.username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => StaffDashboardPage(staff: staff)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نام کاربری یا رمز اشتباه است')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود مسئول داروخانه')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: 'نام کاربری')),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: 'رمز عبور'), obscureText: true),
            const SizedBox(height: 40),
            ElevatedButton(onPressed: _login, child: const Text('ورود')),
          ],
        ),
      ),
    );
  }
}
