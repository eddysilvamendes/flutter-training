import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/models/cart_item.dart';
import 'package:my_second_ecomerce_app/models/order.dart';
import 'package:my_second_ecomerce_app/models/product.dart';
import 'package:my_second_ecomerce_app/models/userModel.dart';
import 'package:my_second_ecomerce_app/services/order.dart';
import 'package:my_second_ecomerce_app/services/user.dart';
import 'package:uuid/uuid.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticaded }

class UserProvider with ChangeNotifier {
  late FirebaseAuth _auth;
  late User _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  late UserModel _userModel;
  OrderServices _orderServices = OrderServices();

  List<UserModel> userList = [];

  UserModel get userModel => _userModel;
  Status get status => _status;
  User get user => _user;
  late List<OrderModel> orders = [];

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_statusonChanged);
    loadUser();
  }

  loadUser() async {
    userList = await _userServices.getusers();
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticaded;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  late List<CartItemModel> cart = [];
  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) {
        _userServices.createUser({
          "name": name,
          "email": email,
          "uid": user.user!.uid,
          "stripeId": "",
          "cart": cart,
        });
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticaded;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticaded;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _statusonChanged(User? event) async {
    if (event == null) {
      _status = Status.Unauthenticaded;
    } else {
      _user = event;
      _userModel = await _userServices.getUserById(user.uid);

      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> addToCart(
      {required ProductModel product,
      required String size,
      required String color}) async {
    try {
      var uuid = Uuid();
      String cartItemId = uuid.v4();
      List<CartItemModel> cart = _userModel.cart;

      Map cartItem = {
        "id": cartItemId,
        "name": product.name,
        "image": product.picture,
        "productId": product.id,
        "price": product.price.toInt(),
        "size": size,
        "color": color
      };

      CartItemModel item = CartItemModel.fromMap(cartItem);
//      if(!itemExists){

      _userServices.addToCart(userId: _user.uid, cartItem: item);
//      }

      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  Future<bool> removeFromCart({required CartItemModel cartItem}) async {
    print("THE PRODUC IS: ${cartItem.toString()}");

    try {
      _userServices.removeFromCart(userId: _user.uid, cartItem: cartItem);
      return true;
    } catch (e) {
      print("THE ERROR ${e.toString()}");
      return false;
    }
  }

  getOrders() async {
    orders = await _orderServices.getUserOrders(userId: _user.uid);
    notifyListeners();
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(user.uid);
    notifyListeners();
  }
}
