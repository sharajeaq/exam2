class Product {
  final int id;
  final String name;
  final String category;
  final double price;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: (json['name'] ?? 'Sin nombre').toString(),
      category: (json['category'] ?? 'Sin categoría').toString(),
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'price': price,
      };
}
