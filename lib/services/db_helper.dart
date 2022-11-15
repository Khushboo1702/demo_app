import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:demoapp/modules/cart_module/data/data.dart';


  //(TODO): Make DBhelper singleton rather than SQFlite instance
  //1)Make DBhelper's constructor private
  //2)Create a nullable static instance of DBhelper
  //3)Create a factory constructor to access the above static instance

  //Database? _db;

  // Future<Database?> get db async {
  //   if (_db != null) {
  //     return _db;
  //   }
  //   _db = await initDatabase();
  //   return _db;
  // }
// class DBhelper {

//   late Database _dbClient;

//   DBhelper._();

//   static DBhelper _db = DBhelper._();

//   factory DBhelper() {
//     return _db;
//   }

//   //Not required , but still in case you want dbClient
//   Database get dbClient => _dbClient;

//   Future<void> initDatabase() async {
//     io.Directory documentDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentDirectory.path, 'cart.db');
//     _dbClient = await openDatabase(path, version: 1, onCreate: _onCreate);
//   }

//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute(
//       'CREATE TABLE cart (userId INTEGER, id INTEGER PRIMARY KEY, title TEXT, quantity INTEGER)',
//     );
//   }

//   Future<Data> insert(Data cart) async {
//     print(cart.toMap());
//     //uniqueId++;
//     await _dbClient.insert('cart', cart.toMap());
//     return cart;
//   }

//   Future<List<Data>> getCartList() async {
//     final List<Map<String, Object?>> queryResult =
//         await _dbClient.query('cart');
//     return queryResult.map((e) => Data.fromJson(e)).toList();
//   }

//   Future<int> delete(int id) async => _dbClient.delete(
//         'cart',
//         where: 'id = ?',
//         whereArgs: [id],
//       );

//   Future<int> updateQuantity(Data cart)async => _dbClient
//       .update('cart', cart.toMap(), where: 'id = ?', whereArgs: [cart.id]);
// }
