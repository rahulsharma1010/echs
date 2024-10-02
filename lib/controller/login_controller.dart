import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController{
  var isLoding = false.obs;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  
  
  Future<void> login() async{
    print('loding');
    isLoding(true);
    final url = Uri.parse('https://fakestoreapi.com/auth/login');
    try{
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
        }
        )
      );

      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        Get.snackbar('Sucess', 'Login Sucessfully!',snackPosition: SnackPosition.BOTTOM);
        print("sucess");
      }
    }catch (e){
      Get.snackbar('Error', 'Try Again',snackPosition: SnackPosition.BOTTOM);
      print("fail");

    }finally{
      isLoding(false);
    }
  }

}