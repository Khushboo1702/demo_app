import 'package:demoapp/modules/cart_module/data/api.dart';
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
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Api api = Api();

  @override
  void initState() {
    super.initState();
  }

  @override
  //BuildContext is a locator that is used to track each widget in a tree and locate them and their position in the tree.

  Widget build(BuildContext context) {
    //(TODO): Don't declare global function

    return ChangeNotifierProvider(
      create: (_) => CartProvider(db: DBhelper()..initDatabase()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DEMO APP',
        home: FutureBuilder<List<Data>>(
          future: api.fetchData(),
          builder: (context, dataSnap) {
            if (!dataSnap.hasData) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return MyWidget(
              data: dataSnap.data ?? [],
            );
          },
        ),
      ),
    );
  }
}
