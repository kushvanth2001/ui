class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final List<String> imageUrls;
  final String category;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrls,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrls: List<String>.from(json['imageUrls']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrls': imageUrls,
      'category': category,
    };
  }
}
