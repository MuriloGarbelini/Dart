class Product {
  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
  });

  final String? id;
  final String name;
  final String description;
  final double price;
  final String category;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      category: json['category']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'category': category,
    };
  }
}
