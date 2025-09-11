// pages/prescription_form_page.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/doctor.dart';
import '../models/prescription.dart';

class PrescriptionFormPage extends StatefulWidget {
  final Doctor doctor;
  const PrescriptionFormPage({super.key, required this.doctor});

  @override
  State<PrescriptionFormPage> createState() => _PrescriptionFormPageState();
}

class _PrescriptionFormPageState extends State<PrescriptionFormPage> {
  final _patientController = TextEditingController();
  final _medicineController = TextEditingController();
  List<String> medicines = [];

  Future<void> _savePrescription() async {
    var box = Hive.box<Prescription>('prescriptions');
    await box.add(Prescription(
      patientName: _patientController.text,
      doctorName: widget.doctor.fullname,
      specialty: widget.doctor.specialty,
      medicines: medicines,
    ));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('نسخه ذخیره شد')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('نوشتن نسخه')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _patientController, decoration: const InputDecoration(labelText: 'نام بیمار')),
            Row(
              children: [
                Expanded(
                  child: TextField(controller: _medicineController, decoration: const InputDecoration(labelText: 'دارو')),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      medicines.add(_medicineController.text);
                      _medicineController.clear();
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (_, i) => ListTile(title: Text(medicines[i])),
              ),
            ),
            ElevatedButton(onPressed: _savePrescription, child: const Text('ذخیره نسخه')),
          ],
        ),
      ),
    );
  }
}
