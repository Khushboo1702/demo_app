import 'package:badges/badges.dart';
import 'package:demoapp/cart_provider.dart';
import 'package:demoapp/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBhelper? dBhelper = DBhelper();
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
                  style: const TextStyle(color: Colors.white),
                );
              }),
            ),
            animationDuration: const Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            child: const Icon(
              Icons.shopping_cart_sharp,
              color: Colors.black,
            ),
          )),
          const SizedBox(width: 20.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Data>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            // Image(
                            //   image: AssetImage('images/empty_cart.png'),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Your cart is empty !',
                                style: Theme.of(context).textTheme.headline5),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                'Explore products and shop your\nfavourite items',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle2)
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.start,
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      snapshot
                                                          .data![index].title
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        dBhelper!.delete(
                                                            snapshot
                                                                .data![index]
                                                                .id!);
                                                        cart.removeCounter();
                                                      },
                                                      child: Icon(Icons.delete))
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Row(
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      int quantity = snapshot
                                                                          .data![
                                                                              index]
                                                                          .quantity!;

                                                                      quantity--;

                                                                      if (quantity >
                                                                          0) {
                                                                        dBhelper!
                                                                            .updateQuantity(
                                                                          Data(
                                                                            id: snapshot.data![index].id!,
                                                                            userId:
                                                                                snapshot.data![index].userId,
                                                                            title:
                                                                                snapshot.data![index].title,
                                                                            quantity:
                                                                                quantity,
                                                                          ),
                                                                        )
                                                                            .then(
                                                                                (value) {
                                                                          quantity =
                                                                              0;
                                                                        }).onError((error,
                                                                                stackTrace) {
                                                                          print(
                                                                              error.toString());
                                                                        });
                                                                      }
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .remove,
                                                                      color: Colors
                                                                          .white,
                                                                    )),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          20,
                                                                    )),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: InkWell(
                                                                      onTap: () {
                                                                        int quantity = snapshot
                                                                            .data![index]
                                                                            .quantity!;

                                                                        quantity++;

                                                                        dBhelper!
                                                                            .updateQuantity(
                                                                                Data(
                                                                          id: snapshot
                                                                              .data![index]
                                                                              .id!,
                                                                          userId: snapshot
                                                                              .data![index]
                                                                              .userId,
                                                                          title: snapshot
                                                                              .data![index]
                                                                              .title,
                                                                          quantity:
                                                                              quantity,
                                                                        ))
                                                                            .then(
                                                                                (value) {
                                                                          quantity =
                                                                              0;
                                                                        }).onError((error,
                                                                                stackTrace) {
                                                                          print(
                                                                              error.toString());
                                                                        });
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  ;
                  return Text("LOADING");
                })
          ],
        ),
      ),
    );
  }
}
