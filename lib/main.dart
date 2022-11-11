import 'dart:async';

import 'package:demoapp/modules/cart_module/bloc/cart_bloc.dart';
import 'package:demoapp/modules/cart_module/data/api.dart';
import 'package:demoapp/modules/cart_module/ui/cart_addition.dart';
import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:demoapp/services/sembastDB.dart';
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
  late final AppDatabase db1;
  CartBloc bloc = CartBloc();
  @override
  void initState() {
    super.initState();
    db1 = AppDatabase();
  }

  @override
  //BuildContext is a locator that is used to track each widget in a tree and locate them and their position in the tree.

  Widget build(BuildContext context) {
    //(TODO): Don't declare global function
    // StreamController<double> controller = StreamController<double>();
    // Stream stream = controller.stream;

    return FutureBuilder(
        future: db1.openDatabase(),
        builder: (context, snapshot) {
          return MaterialApp(
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
                  bloc: bloc,
                );
              },
            ),
          );
        });
  }
}
