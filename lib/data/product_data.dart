import '../models/product.dart';

class ProductData {
  static List<Product> allProducts = [
    Product(
        index: 1,
        name: "Essay Writing",
        question: "generate the best essay about",
        userInput: true,
        generateBgImage: false,
        alert: false,
        picture: "https://kdjfksfjsdklfs.com",
        bg: ""),
    Product(
        index: 2,
        name: "Article Writing",
        question: "generate the best article",
        userInput: true,
        generateBgImage: false,
        alert: false,
        picture: "https://kdjfksfjsdklfs.com",
        bg: ""),
    Product(
        index: 3,
        name: "Paragraph Writing",
        question: "Write eyecatching pragraph",
        userInput: true,
        generateBgImage: false,
        alert: false,
        picture: "https://kdjfksfjsdklfs.com",
        bg: ""),
    Product(
        index: 4,
        name: "Health Questions",
        question: "Health Questions",
        userInput: true,
        generateBgImage: false,
        alert: false,
        picture: "https://kdjfksfjsdklfs.com",
        bg: ""),
    Product(
        index: 5,
        name: "Mathematical Questions",
        question: "Mathematical Questions",
        userInput: true,
        generateBgImage: false,
        alert: false,
        picture: "https://kdjfksfjsdklfs.com",
        bg: ""),
    Product(
      index: 6,
      name: "Motivational Quotes",
      question: "Write an amazing motivational quote of the day",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "Motivational",
    ),
    Product(
      index: 7,
      name: "Life Quotes",
      question: "Write an amazing Life quote of the day",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "Nature",
    ),
    Product(
      index: 8,
      name: "Love Quotes for Him",
      question: "love quote for him",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "Love",
    ),
    Product(
      index: 9,
      name: "Inspirational Quotes",
      question: "Write the best inspirational quote of the day",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "inspiration",
    ),
    Product(
      index: 10,
      name: "Fun Quotes",
      question: "Write the best fun quote of the day",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "fun",
    ),
    Product(
      index: 11,
      name: "Joke of the day",
      question: "Write the best joke of the day",
      userInput: false,
      generateBgImage: true,
      alert: false,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "comedy",
    ),
    Product(
      index: 12,
      name: "Happy Birthday",
      question: "Write the Best happy birthday wish for ",
      userInput: false,
      generateBgImage: true,
      alert: true,
      picture: "https://kdjfksfjsdklfs.com",
      bg: "comedy",
    ),

    // Add other products here
  ];

  static List<Product> getFilteredProducts(String query, int tabIndex) {
    List<Product> filteredProducts = allProducts.where((product) {
      if (tabIndex == 0 && product.userInput) {
        return true;
      } else if (tabIndex == 1 && !product.userInput) {
        return true;
      }
      return false;
    }).toList();

    if (query.isEmpty) {
      return filteredProducts;
    }
    return filteredProducts.where((product) {
      final name = product.name.toLowerCase();
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery);
    }).toList();
  }
}
