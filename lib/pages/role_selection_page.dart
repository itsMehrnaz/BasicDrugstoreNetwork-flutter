// pages/role_selection_page.dart
import 'package:flutter/material.dart';
import 'doctor_login_page.dart';
import 'staff_login_page.dart';
import 'customer_login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('انتخاب نقش')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const CustomerLoginPage())),
              child: const Text('ورود مشتری'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const DoctorLoginPage())),
              child: const Text('ورود پزشک'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const StaffLoginPage())),
              child: const Text('ورود مسئول داروخانه'),
            ),
          ],
        ),
      ),
    );
  }
}
