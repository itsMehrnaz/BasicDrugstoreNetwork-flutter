// pages/staff_dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/prescription.dart';
import '../models/staff.dart';

class StaffDashboardPage extends StatelessWidget {
  final Staff staff;
  const StaffDashboardPage({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Prescription>('prescriptions');
    return Scaffold(
      appBar: AppBar(title: Text('پروفایل ${staff.fullname}')),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Prescription> box, _) {
          if (box.values.isEmpty) return const Center(child: Text('هیچ نسخه‌ای وجود ندارد'));
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (_, i) {
              var pres = box.getAt(i)!;
              return ListTile(
                title: Text('بیمار: ${pres.patientName}'),
                subtitle: Text('پزشک: ${pres.doctorName} (${pres.specialty})\nداروها: ${pres.medicines.join(", ")}'),
                trailing: Checkbox(
                  value: pres.isCompleted,
                  onChanged: (val) {
                    pres.isCompleted = val ?? false;
                    pres.save();
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
