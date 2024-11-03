import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_cart_api/model/product_model.dart';

class ScreenTwoController with ChangeNotifier {
  List<ProductModel> productList = [];
  bool isLoading = false;
  bool isProductLoading = false;
  List categoryList = ["All"]; // to store categories from api
  int selectedCategoryIndex = 0;
  bool iscategoryLoading = false;
  Future<void> getAllproducts() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.parse("https://fakestoreapi.com/products");
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        // if the response is success ,we get json data
        productList =
            productModelFromJson(res.body); // to convert the json data to dart
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getcategory() async {
    categoryList = ["All"]; // to avoid repetition in category after refreshing
    //iscategoryLoading = true;
  isLoading =true;
    notifyListeners();
    try {
      var urlcategory =
          Uri.parse("https://fakestoreapi.com/products/categories");
      var response = await http.get(urlcategory);
      if (response.statusCode == 200) {
        categoryList.addAll(jsonDecode(
            response.body)); // we use "add" to get the category "All"
        // we use "addAll" to get the categories in separate container
        // categoryList = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
   // iscategoryLoading = false;
     isLoading =true;
    notifyListeners();
  }

  Future<void> getProductsByCategory(String categories) async {
    //isLoading = true;
    isProductLoading = true;
    notifyListeners();
    var url =
        Uri.parse("https://fakestoreapi.com/products/category/$categories");

    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        // if the response is success ,we get json data
        productList =
            productModelFromJson(res.body); // to convert the json data to dart
      }
    } catch (e) {
      print(e);
    }
    //isLoading = false;
    isProductLoading = false;
    notifyListeners();
  }

  // to change color of the container while selecting
  void onCategorySelection(int index) {
    selectedCategoryIndex = index;
    notifyListeners();
    if (selectedCategoryIndex == 0) {
      getAllproducts();
    } else {
      getProductsByCategory(categoryList[selectedCategoryIndex]);
    }
  }
}
