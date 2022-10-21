import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/services/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

//TODO: Acting as a controller here
class CartProvider with ChangeNotifier {
  final DBhelper dbHelper;

  DBhelper db = DBhelper();
  int _counter = 0;

  CartProvider(this.dbHelper);

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
    //TODO: Add in DB
    //TODO : Cart update
    //TODO : UI notify
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
    //_total = prefs.getDouble('total') ?? 0.0;
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

// void addtotal(double productprice) {
//   _total += productprice;
//   _setPrefItems();
//   notifyListeners();
// }

// void removetotal(double productprice) {
//   _total -= productprice;
//   _setPrefItems();
//   notifyListeners();
// }

// double gettotal(double productprice) {
//   _getPrefItems();
//   return _total;
// }
}
