class Product {
  String id;
  String name;
  String category;
  double price;
  String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  // Chuyển đối tượng Product thành JSON để lưu vào Firestore
  Map<String, dynamic> toJson() => {
        'product_name': name,
        'category': category,
        'price': price,
        'image_url': imageUrl,
      };

  // Tạo một đối tượng Product từ JSON
  factory Product.fromJson(Map<String, dynamic> json, String id) {
    return Product(
      id: id,
      name: json['product_name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
}
