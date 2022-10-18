import 'dart:async';
import 'package:demoapp/cart_addition.dart';
import 'package:demoapp/cart_provider.dart';
import 'package:demoapp/login.dart';
import 'package:demoapp/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapp/data.dart';
import 'package:demoapp/db_helper.dart';

void main() => MyApp();
// runApp(MaterialApp(
//   debugShowCheckedModeBanner: false,
//   home: MyLogin(),
//   routes: {
//     'register': (context) => MyRegister(),
//     'login': (context) => MyLogin(),
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
