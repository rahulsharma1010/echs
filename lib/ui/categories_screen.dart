import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final url = 'https://fakestoreapi.com/products/categories';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _categories = List<String>.from(json.decode(response.body));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to Cart Screen
              Get.toNamed('/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 10),
            child: Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(_categories[index]),
                )
              ),
            )
            ),
            onTap: () {
              Get.toNamed('/products', arguments: _categories[index]);
            },
          );
        },
      ),
    );
  }
}
