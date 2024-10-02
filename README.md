# Fake Store Flutter Application

This Flutter application interacts with the Fake Store API to demonstrate various functionalities such as login, product listing, cart management, and more. The app provides a simple user interface to login, browse products by categories, and manage a shopping cart.

## Features

1. **Login Screen**:
   - Users can log in using a username and password.
   - Endpoint: `https://fakestoreapi.com/auth/login`
   - Method: `POST`

2. **Display All Categories**:
   - Lists all available product categories.
   - Endpoint: `https://fakestoreapi.com/products/categories`
   - Method: `GET`

3. **Display Products in a Selected Category**:
   - Displays products filtered by the selected category.
   - When a user selects a category, only the products from that category are displayed.

4. **Display Details of a Single Product**:
   - Shows detailed information about a specific product.
   - Endpoint: `https://fakestoreapi.com/products/{productId}`
   - Method: `GET`

5. **Add to Cart**:
   - Allows users to add products to their shopping cart.
   - Endpoint: `https://fakestoreapi.com/carts`
   - Method: `POST`
   - Payload: `{ "userId": "your_user_id", "products": [{ "productId": 1, "quantity": 1 }] }`

6. **Remove Product from Cart**:
   - Allows users to remove products from the cart.
   - Endpoint: `https://fakestoreapi.com/carts/{cartId}/remove`
   - Method: `DELETE`

7. **Update Product Quantity in Cart**:
   - Allows users to update the quantity of a product in the cart.
   - Endpoint: `https://fakestoreapi.com/carts/{cartId}`
   - Method: `PUT`
   - Payload: `{ "productId": 1, "quantity": 2 }`

## Prerequisites

- **Flutter SDK**: Make sure Flutter SDK is installed on your system.
  - [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Android Studio**: Install the latest version of Android Studio for running and testing the app.
  - [Android Studio Download](https://developer.android.com/studio)
- **Git**: Ensure Git is installed on your system.
  - [Git Installation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

## Installation Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/fake-store-flutter-app.git
   cd fake-store-flutter-app
