import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_api/model/product_model.dart';

class ScreenTwoController with ChangeNotifier {
  List<ProductModel> newproduct = [];
  bool isLoading = false;
  List categoryList = ["All"];
  int selectedIndex = 0;
  bool iscategoryLoading = false;
  Future<void> getAllproducts() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.parse("https://fakestoreapi.com/products");

    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        // if the response is success ,we get json data
        newproduct =
            productModelFromJson(res.body); // to convert the json data to dart
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getcategory() async {
    categoryList = ["All"];
    iscategoryLoading = true;
    notifyListeners();
    try {
      var urlcategory =
          Uri.parse("https://fakestoreapi.com/products/categories");
      var response = await http.get(urlcategory);
      if (response.statusCode == 200) {
        categoryList.addAll(jsonDecode(response.body));
      }
    } catch (e) {
      print(e);
    }
    iscategoryLoading = false;
    notifyListeners();
  }

 

  Future<void> getProductsByCategory(String categories) async {
     isLoading = true;
    notifyListeners();
    var url = Uri.parse("https://fakestoreapi.com/products/categories/$categories");

    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        // if the response is success ,we get json data
        newproduct =
            productModelFromJson(res.body); // to convert the json data to dart
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  void onCategorySelection(int index){
  selectedIndex = index;
  notifyListeners();
  if(selectedIndex == 0){
    getAllproducts();
  }else{
   getProductsByCategory(categoryList[selectedIndex]);
  }
  }

  
}
