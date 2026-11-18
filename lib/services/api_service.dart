import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ApiService {
  static const String _baseUrl = 'https://fakestoreapi.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat daftar produk (${response.statusCode})');
    }
    final List data = jsonDecode(response.body);
    return data.map((e) => Product.fromJson(e)).toList();
  }

  static Future<Product> fetchProductDetail(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat detail produk (${response.statusCode})');
    }
    final data = jsonDecode(response.body);
    return Product.fromJson(data);
  }
}
