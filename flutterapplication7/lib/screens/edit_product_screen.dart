import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductScreen extends StatefulWidget {
  final String productId;

  EditProductScreen({required this.productId});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    loadProductData();
  }

  // Lấy dữ liệu sản phẩm hiện tại từ Firestore
  void loadProductData() async {
    var productDoc = await FirebaseFirestore.instance.collection('products').doc(widget.productId).get();
    setState(() {
      nameController.text = productDoc['product_name'];
      categoryController.text = productDoc['category'];
      priceController.text = productDoc['price'].toString();
      imageUrl = productDoc['image_url'];
    });
  }

  // Cập nhật sản phẩm trong Firestore
  void updateProduct() {
    FirebaseFirestore.instance.collection('products').doc(widget.productId).update({
      'product_name': nameController.text,
      'category': categoryController.text,
      'price': double.parse(priceController.text),
      'image_url': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
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
              onPressed: updateProduct,
              child: Text("Update Product"),
            ),
          ],
        ),
      ),
    );
  }
}
