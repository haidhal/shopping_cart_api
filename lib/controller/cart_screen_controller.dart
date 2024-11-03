//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopping_cart_api/model/cart_model.dart';

class CartScreenController with ChangeNotifier {
  final cartBox = Hive.box<CartModel>("cartBox");
  List<CartModel> cart = [];
  List keys = [];
  double totalCartValue = 0;
  Future<void> addProduct(
      {required int id,
      String? image,
      String? desc,
      String? name,
      required double price}) async {
    // await cartBox.add(CartModel(
    //     name: name, id: id, desc: desc, image: image, price: price, qty: cartQuantity
    //     ));
    bool isAlreadyInCart = false;
    for (int i = 0; i < cart.length; i++) {
      if (id == cart[i].id) {
        isAlreadyInCart = true;
      }
      print("!!!!! $isAlreadyInCart");
    }

    if (isAlreadyInCart == true) {
      print(" !!!!!!already added");
    } else {
      await cartBox.add(CartModel(
          name: name, id: id, desc: desc, image: image, price: price, qty: 1));
    }
    getProduct();
  }

  void getProduct() {
    keys = cartBox.keys.toList();
    cart = cartBox.values.toList();
    calculateTotalAmount();
    notifyListeners();
    debugPrint(keys.toString());
  }

  void removeProduct(int index) {
    cartBox.deleteAt(index);
    getProduct();
    print("!!! remove");
  }

  void incrementQty(int index) {
    keys[index];
    int currentQty = cart[index].qty ?? 1;
    currentQty++;
    cartBox.put(
        keys[index],
        CartModel(
          id: cart[index].id,
          desc: cart[index].desc,
          image: cart[index].image,
          name: cart[index].name,
          price: cart[index].price,
          qty: currentQty,
        ));
  }

  void decrementQty(int index) {
    int cartQuantity = cart[index].qty ?? 1;
    if (cartQuantity > 1) {
      cartQuantity--;
      cartBox.put(
          keys[index],
          CartModel(
            id: cart[index].id,
            desc: cart[index].desc,
            image: cart[index].image,
            name: cart[index].name,
            price: cart[index].price,
            qty: cartQuantity,
          ));
    }
  }

  calculateTotalAmount(){
  totalCartValue = 0;
  for(int i = 0;i < cart.length ; i++){
    totalCartValue += (cart[i].price! * cart[i].qty!);
  }
  }
}
