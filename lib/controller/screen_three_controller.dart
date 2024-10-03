import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_api/model/product_model.dart';

class ScreenThreeController with ChangeNotifier{
ProductModel? ProductDetails;
  Future<void> getProductDetails(String productId) async {
  try { var url = Uri.parse("https://fakestoreapi.com/products$productId");
    var response = await http.get(url);
    if(response.statusCode == 200){
     ProductDetails =singleProductModelFromJson(response.body);
    }
    }catch(e){
      print(e);
    }
    notifyListeners();
  }
}