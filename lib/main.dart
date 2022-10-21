import 'dart:async';
import 'package:demoapp/modules/cart_module/ui/cart_addition.dart';
import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/services/db_helper.dart';

import 'modules/authentication/login/login.dart';

void main() => runApp(
      Login(),
    );

// runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: MyLogin(),
//   routes: {
//     'register': (context) => MyRegister(),
//     'authentication': (context) => MyLogin(),
//   },
// ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Data>> futureData;
  DBhelper? dbHelper = DBhelper();

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DEMO APP',
        home: MyWidget(
          futureData: futureData,
          dbHelper: dbHelper,
        ),
      ),
    );
  }
}
