import 'package:badges/badges.dart';
import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:demoapp/modules/cart_module/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late CartProvider cart;

  @override
  void initState() {
    super.initState();
    cart = Provider.of<CartProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
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
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    snapshot.data![index].title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    await cart.removeItem(
                                                      snapshot.data![index],
                                                    );
                                                    cart.removeCounter();
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            children: [
                                                              InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;

                                                                    quantity--;

                                                                    if (quantity >
                                                                        0) {
                                                                      await cart
                                                                          .updateItem(
                                                                        Data(
                                                                          id: snapshot
                                                                              .data![index]
                                                                              .id,
                                                                          userId: snapshot
                                                                              .data![index]
                                                                              .userId,
                                                                          title: snapshot
                                                                              .data![index]
                                                                              .title,
                                                                          quantity:
                                                                              quantity,
                                                                        ),
                                                                      );
                                                                      // quantity =
                                                                      // 0;
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        20,
                                                                  )),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                child: InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      int quantity = snapshot
                                                                          .data![
                                                                              index]
                                                                          .quantity!;

                                                                      quantity++;
                                                                      await cart
                                                                          .updateItem(
                                                                        Data(
                                                                          id: snapshot
                                                                              .data![index]
                                                                              .id,
                                                                          userId: snapshot
                                                                              .data![index]
                                                                              .userId,
                                                                          title: snapshot
                                                                              .data![index]
                                                                              .title,
                                                                          quantity:
                                                                              quantity,
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons.add,
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
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
