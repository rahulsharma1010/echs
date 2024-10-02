import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> _cartProducts = [];
  int _cartId = 1; // Replace with dynamic cart ID

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    final url = 'https://fakestoreapi.com/carts/$_cartId';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        _cartProducts = json.decode(response.body)['products'];
      });
    }
  }

  Future<void> _removeFromCart(int productId) async {
    final url = 'https://fakestoreapi.com/carts/$_cartId/remove';
    final response = await http.delete(
      Uri.parse(url),
      body: json.encode({
        'productId': productId,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Product removed from cart');
      _fetchCartItems(); // Refresh the cart items after removal
    } else {
      Get.snackbar('Error', 'Failed to remove product');
    }
  }

  Future<void> _updateQuantity(int productId, int quantity) async {
    final url = 'https://fakestoreapi.com/carts/$_cartId';
    final response = await http.put(
      Uri.parse(url),
      body: json.encode({
        'productId': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Quantity updated');
      _fetchCartItems(); // Refresh cart after update
    } else {
      Get.snackbar('Error', 'Failed to update quantity');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: _cartProducts.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _cartProducts.length,
              itemBuilder: (context, index) {
                final product = _cartProducts[index];
                int quantity = product['quantity'];

                return ListTile(
                  title: Text('Product ID: ${product['productId']}'),
                  subtitle: Text('Quantity: $quantity'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                            _updateQuantity(product['productId'], quantity);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                          _updateQuantity(product['productId'], quantity);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeFromCart(product['productId']);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
