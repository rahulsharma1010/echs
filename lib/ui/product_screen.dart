import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List _products = [];
  String _category = '';

  @override
  void initState() {
    super.initState();
    _category = Get.arguments;
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final url = 'https://fakestoreapi.com/products/category/$_category';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _products = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products in $_category')),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 10),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Padding(padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(_products[index]['title'],style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                            ),),)
                          )
                        ],
                      )
                  ),
                )
            ),
            onTap: () {
              Get.toNamed('/productDetail', arguments: _products[index]['id']);
            },
          );
        },
      ),
    );
  }
}
