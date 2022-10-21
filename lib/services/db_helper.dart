import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:demoapp/modules/cart_module/data/data.dart';

class DBhelper {
  //(TODO): Make DBhelper singleton rather than SQFlite instance
  //1)Make DBhelper's constructor private
  //2)Create a nullable static instance of DBhelper
  //3)Create a factory constructor to access the above static instance

  Database? _db;
  //int uniqueId = 0;

  Future<Database?> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db;
  }

  Future<Database?> initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart (userId INTEGER, id INTEGER PRIMARY KEY, title TEXT, quantity INTEGER)',
    );
  }

  Future<Data> insert(Data cart) async {
    print(cart.toMap());

    var dbClient = await db;
    //uniqueId++;
    await dbClient!.insert('cart', cart.toMap());
    return cart;
  }

  Future<List<Data>> getCartList() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cart');
    return queryResult.map((e) => Data.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateQuantity(Data cart) async {
    var dbClient = await db;
    return await dbClient!
        .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
  }
}
