import 'dart:async';
import 'package:demoapp/modules/cart_module/ui/cart_addition.dart';
import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:demoapp/services/db_helper.dart';

void main() => runApp(
      const MyApp(),
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
  DBhelper? dbHelper = DBhelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(DBhelper()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DEMO APP',
        home: FutureBuilder<List<Data>>(
            future: fetchData(),
            builder: (context, dataSnap) {
              if (dataSnap.hasData && (dataSnap.data ?? []).isNotEmpty) {
                return MyWidget(
                  data: dataSnap.data ?? [],
                  dbHelper: dbHelper,
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
