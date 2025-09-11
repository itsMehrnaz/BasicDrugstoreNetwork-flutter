// main.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/doctor.dart';
import 'models/staff.dart';
import 'models/prescription.dart';
import 'pages/role_selection_page.dart';
import 'models/customer.dart';
import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  //Hive برای ذخیره‌سازی محلی روی دستگاه

  Hive.registerAdapter(DoctorAdapter());
  Hive.registerAdapter(StaffAdapter());
  Hive.registerAdapter(PrescriptionAdapter());

// main.dart → داخل main() بعد از Hive.registerAdapter
Hive.registerAdapter(CustomerAdapter());
Hive.registerAdapter(ProductAdapter());

var customerBox = await Hive.openBox<Customer>('customers');
var productBox = await Hive.openBox<Product>('products');

if (productBox.isEmpty) {
  productBox.addAll([
    Product(name: 'استامینوفن', price: 20000, discount: 15000, image: 'https://5.imimg.com/data5/SELLER/Default/2023/8/335065442/NQ/YG/JJ/66315538/cough-medicine-syrup.jpg', volume: '500mg', stock: 10),
    Product(name: 'ایبوپروفن', price: 30000, discount: 25000, image: 'https://frankrosspharmacy.com/_next/image?url=https%3A%2F%2Femami-production-2.s3.amazonaws.com%2Fvariant_images%2Ffiles%2F000%2F000%2F827%2Fnormal_webp%2FFR-15721.webp%3F1649921619&w=640&q=75', volume: '400mg', stock: 15),
    Product(name: 'آموکسی‌سیلین', price: 40000, discount: 35000, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaLtQuNMnnWYCF0KdqeuU5t18aLBCy1GnSRess5YeFY_GMog22r8oyusg5RSsCpwWwqFw&usqp=CAU', volume: '250mg', stock: 12),
  ]);
}


  var doctorBox = await Hive.openBox<Doctor>('doctors');
  var staffBox = await Hive.openBox<Staff>('staff');
  await Hive.openBox<Prescription>('prescriptions');

  // افزودن دکترها فقط یک بار (اگر دیتابیس خالی بود)
  if (doctorBox.isEmpty) {
    doctorBox.addAll([
      Doctor(username: 'drreza', password: '1234', fullname: 'دکتر رضا محمدی', specialty: 'قلب و عروق'),
      Doctor(username: 'drsara', password: '1276', fullname: 'دکتر سارا احمدی', specialty: 'داخلی'),
      Doctor(username: 'drhossein', password: '1344', fullname: 'دکتر حسین مرادی', specialty: 'ارتوپدی'),
      Doctor(username: 'drmaryam', password: '1284', fullname: 'دکتر مریم کاظمی', specialty: 'اطفال'),
      Doctor(username: 'dralireza', password: '9874', fullname: 'دکتر علیرضا نوری', specialty: 'پوست و مو'),
    ]);
  }

  if (staffBox.isEmpty) {
    staffBox.addAll([
      Staff(username: 'staffreza', password: '3456', fullname: 'دکتر داروساز رضا شریفی'),
      Staff(username: 'staffsara', password: '7654', fullname: 'دکتر داروساز سارا محمدی'),
      Staff(username: 'staffhossein', password: '0987', fullname: 'دکتر داروساز حسین عباسی'),
      Staff(username: 'staffmaryam', password: '2345', fullname: 'دکتر داروساز مریم رحیمی'),
      Staff(username: 'staffalireza', password: '7645', fullname: 'دکتر داروساز علیرضا احمدپور'),
    ]);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'داروخانه',
      theme: ThemeData(fontFamily: 'Vazir', primarySwatch: Colors.teal),
      home: const RoleSelectionPage(),
    );
  }
}
