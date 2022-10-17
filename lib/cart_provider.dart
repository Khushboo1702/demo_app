import 'package:demoapp/data.dart';
import 'package:demoapp/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DBhelper db = DBhelper();
  int _counter = 0;
  int get counter => _counter;

  double _total = 0.0;
  double get total => _total;

  late Future<List<Data>> _cart;
  Future<List<Data>> get cart => _cart;

  Future<List<Data>> getData() async {
    _cart = db.getCartList();
    return _cart;
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
    _total = prefs.getDouble('total') ?? 0.0;
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

  void addtotal(double productprice) {
    _total += productprice;
    _setPrefItems();
    notifyListeners();
  }

  void removetotal(double productprice) {
    _total -= productprice;
    _setPrefItems();
    notifyListeners();
  }

  double gettotal(double productprice) {
    _getPrefItems();
    return _total;
  }
}
