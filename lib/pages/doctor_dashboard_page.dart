// pages/doctor_dashboard_page.dart
import 'package:flutter/material.dart';
import '../models/doctor.dart';
import 'prescription_form_page.dart';

class DoctorDashboardPage extends StatelessWidget {
  final Doctor doctor;
  const DoctorDashboardPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('پروفایل ${doctor.fullname}')),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 60),
            Text('تخصص: ${doctor.specialty}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PrescriptionFormPage(doctor: doctor)),
              ),
              child: const Text('نوشتن نسخه'),
            ),
          ],
        ),
      ),
    );
  }
}
