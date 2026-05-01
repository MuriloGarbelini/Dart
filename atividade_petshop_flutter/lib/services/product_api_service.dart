import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';

class ProductApiService {
  const ProductApiService();

  static const String baseUrl =
      'https://68284f236075e87073a6bfc7.mockapi.io/api/v1/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar produtos na API');
    }

    final List<dynamic> body = jsonDecode(response.body) as List<dynamic>;
    return body
        .map((dynamic item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> createProduct(Product product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Erro ao cadastrar produto na API');
    }
  }
}
