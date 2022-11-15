import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/services/sembastDB.dart';

class CartRepo {
  AppDatabase db = AppDatabase();
  Future<Data> addItem(Data data) async {
    return await db.insert(data);
  }

  Future<Data> removeItem(Data data) async {
    await db.delete(data.id);
    return data;
  }

  Future<List<Data>> getData() async {
    return db.getCartList();
  }

  Future<void> updateItem(Data data) async {
    await db.updateQuantity(data);
  }

  Future<bool> containsData(Data data) => db.containsData(data);
}
