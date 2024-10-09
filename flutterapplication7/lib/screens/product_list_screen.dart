import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var products = snapshot.data!.docs;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index];
              return ListTile(
                leading: Image.network(product['image_url']),
                title: Text(product['product_name']),
                subtitle: Text('Category: ${product['category']} - Price: ${product['price']}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('products')
                        .doc(product.id)
                        .delete();
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
