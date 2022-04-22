import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/popular_product_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get item => _items;

  //List only for storage in sharedPreference
  List<CartModel> storageItems = [];

  void addItem(ProductsModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          img: value.img,
          name: value.name,
          price: value.price,
          isExist: true,
          quantity: value.quantity! + quantity,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
      /*  Get.snackbar(
        "Updated",
        "Cart has been updated",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        // ignore: prefer_const_constructors
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.red,
        ),
      );*/
    } else {
      //veify if key has been insert on map or not
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            img: product.img,
            name: product.name,
            price: product.price,
            isExist: true,
            quantity: quantity,
            time: DateTime.now().toString(),
            product: product,
          );
        });
        Get.snackbar(
          "Added",
          "Added to the cart",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.red,
          ),
        );
      } else {
        Get.snackbar(
          "ERRROR",
          "Can't add item to the cart. The quantity is 0! ",
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.warning,
            color: Colors.red,
          ),
        );
      }
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  bool existInCart(ProductsModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductsModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      //same as totalQuantity = totalQuantity + value.quantity
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  List<CartModel> getCartData() {
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> item) {
    storageItems = item;
    // print("Lengh Cart Item :" + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  List<CartModel> getCartHistoryList() {
    return cartRepo.getHistoryList();
  }

  set setItems(Map<int, CartModel> setItems) {
    _items = {};
    _items = setItems;
  }

  void addToCartList() {
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory() {
    cartRepo.clearCartHistory();
    update();
  }
}
