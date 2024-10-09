import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapplication7/screens/add_product_screen.dart';
import 'package:flutterapplication7/screens/product_list_screen.dart';

void main() async {
  // Khởi tạo Firebase trước khi chạy ứng dụng
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListScreen(), // Màn hình hiển thị danh sách sản phẩm sẽ là trang chính
      routes: {
        '/add-product': (context) => AddProductScreen(),
      },
    );
  }
}
