import 'package:ehsc/model/AddToCartModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Map _product = {};

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final productId = Get.arguments;
    final url = 'https://fakestoreapi.com/products/$productId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _product = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_product['title'] ?? 'Product Detail')),
      body: _product.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(_product['image']),
                  Text(_product['title']),
                  Text('\$${_product['price']}'),
                  ElevatedButton(
                    onPressed: _addToCart,
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _addToCart() async {
    // Retrieve the userId (token) from SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('token'); // Get the saved userId token

    if (userId == null) {
      Get.snackbar('Error', 'User not logged in');
      return; // Stop if userId is not available
    }

    final url = 'https://fakestoreapi.com/carts';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'userId': userId,
        'products': [
          {'productId': _product['id'], 'quantity': 1}
        ]
      }),
    );

    if (response.statusCode == 200) {
      // Parse the response into CartResponseModel
      final jsonResponse = json.decode(response.body);
      final CartResponseModel cartResponse = CartResponseModel.fromJson(jsonResponse);

      // Optionally, save cart details to SharedPreferences or another form of local storage
      await prefs.setString('cartData', json.encode(cartResponse.toJson()));

      Get.snackbar('Success', 'Product added to cart');
    } else {
      Get.snackbar('Error', 'Failed to add product to cart');
    }
  }
}
