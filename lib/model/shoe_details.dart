class ShoeDetailsModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double discount;
  final double deliveryCharge;
  final List<String> images;
  final List<String> colors;
  final List<String> sizes;
  final List<String> catergory;

  ShoeDetailsModel( {
    required this.id,
    required this.name,
    required this.description,
    required this.price,
     this.discount=0,
    required this.deliveryCharge,
    required this.images,
    required this.colors,
    required this.sizes,
    required this.catergory,
  });

  // Convert a ShoeDetailsModel instance into a Map (for JSON serialization)
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'discount': discount,
        'deliveryCharge': deliveryCharge,
        'images': images,
        'colors': colors,
        'sizes': sizes,
        'catergory': catergory
      };

  // Construct a ShoeDetailsModel from a Map (for JSON deserialization)
  factory ShoeDetailsModel.fromJson(Map<String, dynamic> json) {
    return ShoeDetailsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      discount: json['discount'],
      deliveryCharge: json['deliveryCharge'],
      images: List<String>.from(json['images']),
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json['sizes']),
      catergory: List<String>.from(json['catergory'])
    );
  }
}
