import 'dart:async';

import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  late Database _dbClient;
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  // Completer is used for transforming synchronous code into asynchronous code.
  //late Completer<Database> _dbOpenCompleter;

  AppDatabase._();

  factory AppDatabase() {
    return _singleton;
  }

  // Future<Database> get database async {
  //   if (_dbOpenCompleter == null) {
  //     _dbOpenCompleter = Completer();

  //     _openDatabase();
  //   }

  //   return _dbOpenCompleter.future;
  // }

  Future openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'StudentsDB.db');

    _dbClient = await databaseFactoryIo.openDatabase(dbPath);

    // Any code awaiting the Completer's future will now start executing
    // _dbOpenCompleter.complete(database);
  }

  static const String folderName = "Items";
  final _cartFolder = intMapStoreFactory.store(folderName);

  //Future<Database> get _db async => await AppDatabase.instance.database;

  Future<Data> insert(Data cart) async {
    await _cartFolder.add(_dbClient, cart.toMap());
    return cart;
  }

  Future<bool> containsData(Data cart) async {
    final finder = Finder(filter: Filter.equals('id', cart.id));
    final data = await _cartFolder.findFirst(_dbClient, finder: finder);
    return data != null;
  }

  Future<Data> updateQuantity(Data cart) async {
    final finder = Finder(filter: Filter.equals('id', cart.id));
    _cartFolder.update(_dbClient, cart.toMap(), finder: finder);
    return cart;
  }

  Future delete(int id) async {
    final finder = Finder(filter: Filter.equals('id', id));
    print(finder);
    final identity = await _cartFolder.delete(_dbClient, finder: finder);
    //print(identity);
    return identity;
  }

  Future<List<Data>> getCartList() async {
    final recordSnapshot = await _cartFolder.find(await _dbClient);
    return recordSnapshot.map((snapshot) {
      final books = Data.fromJson(snapshot.value);
      return books;
    }).toList();
  }
}
