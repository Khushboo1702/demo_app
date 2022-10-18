import 'package:badges/badges.dart';
import 'package:demoapp/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'data.dart';
import 'db_helper.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key, required this.futureData, required this.dbHelper});
//for UI
  final Future<List<Data>> futureData;
  //for db storage
  final DBhelper? dbHelper;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent,
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CartScreen()));
            },
            child: Center(
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
          ),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Data>>(
          future: widget.futureData,
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
                                  fontWeight: FontWeight.w400, fontSize: 16),
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
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  widget.dbHelper!
                                      .insert(Data(
                                    userId: data[index].userId,
                                    id: index,
                                    title: data[index].title.toString(),
                                  ))
                                      .then((value) {
                                    print('product is added to cart');
                                    context
                                        .read<CartProvider>()
                                        .addtotal(double.parse('1'));
                                    context.read<CartProvider>().addCounter();
                                  }).onError((error, stackTrace) {
                                    print(error.toString());
                                  });
                                },
                                child: const Text("Add To Cart"),
                              ),
                              TextButton(
                                onPressed: () {},
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
                                  Expanded(
                                    child: Text(
                                      data[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  // SizedBox(20),
                                  RawMaterialButton(
                                    onPressed: () {
                                      widget.dbHelper!
                                          .insert(Data(
                                        userId: data[index].userId,
                                        id: index,
                                        title: data[index].title.toString(),
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
    );
  }
}
