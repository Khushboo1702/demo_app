import 'package:badges/badges.dart';
import 'package:demoapp/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.tealAccent,
          title: const Text(
            'My  Products',
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
        body: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Data>> snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Add To Cart"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
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
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Add To Cart"),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
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
                                              snapshot.data![index].title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16),
                                            ),
                                            // SizedBox(20),
                                            RawMaterialButton(
                                              onPressed: () {},
                                              elevation: 2.0,
                                              fillColor: Colors.white,
                                              padding:
                                                  const EdgeInsets.all(15.0),
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
                            }));
                  }
                  return Text('');
                })
          ],
        ));
  }
}
