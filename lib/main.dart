import 'dart:async';
import 'package:badges/badges.dart';
import 'package:demoapp/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demoapp/data.dart';
import 'package:demoapp/db_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //for UI
  late Future<List<Data>> futureData;
  //for db storage
  DBhelper dbHelper = DBhelper();

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
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.tealAccent,
            title: const Text(
              'Product List',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Center(
                  child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: ((context, value, child) {
                    return Text(
                      value.getCounter().toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
                child: const Icon(
                  Icons.shopping_cart_sharp,
                  color: Colors.black,
                ),
              )),
              const SizedBox(width: 20.0)
            ],
          ),
          body: Center(
            child: FutureBuilder<List<Data>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Data>? data = snapshot.data;

                  //list of products
                  return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  data[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Add To Cart"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Delete From Cart"),
                                  ),
                                ],
                              ),
                            );
                          },
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  data[index].title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Add To Cart"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Delete From Cart"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data[index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      // SizedBox(20),
                                      RawMaterialButton(
                                        onPressed: () {
                                          dbHelper
                                              .insert(Data(
                                            userId: data[index].userId,
                                            id: index,
                                            title: data[index].toString(),
                                          ))
                                              .then((value) {
                                            print('product is added to cart');
                                            context
                                                .read<CartProvider>()
                                                .addtotal(double.parse('1'));
                                            context
                                                .read<CartProvider>()
                                                .addCounter();
                                          }).onError((error, stackTrace) {
                                            print(error.toString());
                                          });
                                        },
                                        elevation: 2.0,
                                        fillColor: Colors.white,
                                        padding: const EdgeInsets.all(15.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                          Icons.add,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
