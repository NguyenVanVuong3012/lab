import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterapplication7/models/product.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  String imageUrl = "";

  // Chọn và tải ảnh lên Firebase Storage
  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Tải ảnh lên Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('product_images/${DateTime.now().toString()}');
      UploadTask uploadTask = storageRef.putFile(File(pickedFile.path));
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {}); // Cập nhật UI
    }
  }

  // Thêm sản phẩm vào Firestore
  void addProduct() {
    if (nameController.text.isNotEmpty &&
        categoryController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        imageUrl.isNotEmpty) {
      Product product = Product(
        id: '', // Firebase sẽ tự động tạo ID cho tài liệu
        name: nameController.text,
        category: categoryController.text,
        price: double.parse(priceController.text),
        imageUrl: imageUrl,
      );

      // Thêm sản phẩm vào Firestore
      FirebaseFirestore.instance.collection('products').add(product.toJson());
      
      // Reset form sau khi thêm sản phẩm
      nameController.clear();
      categoryController.clear();
      priceController.clear();
      setState(() {
        imageUrl = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Product Name"),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: "Category"),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: "Price"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            imageUrl.isEmpty
                ? Text("No image selected")
                : Image.network(imageUrl, height: 100),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadImage,
              child: Text("Upload Image"),
            ),
            ElevatedButton(
              onPressed: addProduct,
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
