class Product {
  final String id;
  final String name;
  final String brand;
  final int price;
  final String mainImage;
  final String subImage;
  final String use;
  final String url;
  final double rate;
  final String style;
  final String theme;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.mainImage,
    required this.subImage,
    required this.use,
    required this.url,
    required this.rate,
    required this.style,
    required this.theme,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      brand: map['brand']?.toString() ?? '',
      price: map['price']?.toInt() ?? 0,
      mainImage: map['main_image']?.toString() ?? '',
      subImage: map['sub_image']?.toString() ?? '',
      use: map['use']?.toString() ?? '',
      url: map['url']?.toString() ?? '',
      rate: map['rate']?.toDouble() ?? 0.0,
      style: map['style']?.toString() ?? '',
      theme: map['theme']?.toString() ?? '',
    );
  }
}
