// pages/doctor_login_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/doctor.dart';
import 'doctor_dashboard_page.dart';

class DoctorLoginPage extends StatefulWidget {
  const DoctorLoginPage({super.key});

  @override
  State<DoctorLoginPage> createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  Future<void> _login() async {
    var box = Hive.box<Doctor>('doctors');
    var doctor = box.values.firstWhere(
      (d) => d.username == _userController.text && d.password == _passController.text,
      orElse: () => Doctor(username: '', password: '', fullname: '', specialty: ''),
    );
    if (doctor.username.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DoctorDashboardPage(doctor: doctor)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نام کاربری یا رمز اشتباه است')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ورود پزشک')),
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
