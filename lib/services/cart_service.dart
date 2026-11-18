import 'package:hive_flutter/hive_flutter.dart';

import '../models/product.dart';

class CartService {
  static const String boxName = 'cart';
  static Box get box => Hive.box(boxName);

  static Future<void> addToCart(Product product) async {
    await box.put(product.id, product.toJson());
  }

  static bool isInCart(int productId) {
    return box.containsKey(productId);
  }

  static Future<void> removeFromCart(int productId) async {
    await box.delete(productId);
  }

  static List<Product> getItems() {
    return box.values
        .whereType<Map>()
        .map((value) => Product.fromMap(Map<dynamic, dynamic>.from(value)))
        .toList();
  }

  static int get count => box.length;

  static Future<void> removeItem(dynamic key) async {
    await box.delete(key);
  }
}
