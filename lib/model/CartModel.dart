class Cart {
  int id;
  int userId;
  String date;
  List<CartProduct> products;

  Cart({required this.id, required this.userId, required this.date, required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<CartProduct> productsList = list.map((i) => CartProduct.fromJson(i)).toList();

    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: productsList,
    );
  }
}

class CartProduct {
  int productId;
  int quantity;

  CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
