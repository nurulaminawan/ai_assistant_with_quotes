// lib/models/product.dart
class Product {
  final int index;
  final String name;
  final String question;
  final bool userInput;
  final bool generateBgImage;
  final bool alert;
  final String picture;
  final String bg;

  Product({
    required this.index,
    required this.name,
    required this.question,
    required this.userInput,
    required this.generateBgImage,
    required this.alert,
    required this.picture,
    required this.bg,
  });
}
