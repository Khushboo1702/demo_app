import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Acting as a controller here
class CartProvider with ChangeNotifier {
  final DBhelper db;
  int _counter = 0;

  CartProvider({
    required this.db,
  });

  int get counter => _counter;
  double _total = 0.0;

  double get total => _total;
  late Future<List<Data>> _cart;

  Future<List<Data>> get cart => _cart;

  Future<List<Data>> getData() async {
    _cart = db.getCartList();
    return _cart;
  }

  Future<bool> addToCart(Data data) async {
    //Add in DB
    // Cart update
    // UI notify
    return false;
  }

  void _setPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_item', _counter);
    prefs.setDouble('total', _total);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_item') ?? 0;
    notifyListeners();
  }

  void addCounter() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefItems();
    return _counter;
  }

  Future<Data> addItem(Data data) async {
    return await db.insert(data);
  }

  Future<int> removeItem(Data data) async {
    return await db.delete(data.id);
  }

  Future<void> updateItem(Data data) async {
    await db.updateQuantity(data);
    notifyListeners();
  }
}
