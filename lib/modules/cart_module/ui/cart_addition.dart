import 'package:badges/badges.dart';
import 'package:demoapp/modules/cart_module/bloc/cart_bloc.dart';
import 'package:demoapp/modules/cart_module/controller/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/data.dart';
import 'cart_screen.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
    required this.data,
    required this.bloc,
  });

//for UI
  final List<Data> data;
  final CartBloc bloc;

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  //CartBloc bloc = CartBloc();
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
          // InkWell(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => CartScreen()));
          //   },
          //   child: Center(
          //       child: Badge(
          //     badgeContent: Consumer<CartProvider>(
          //       builder: ((context, value, child) {
          //         return Text(
          //           value.getCounter().toString(),
          //           style: TextStyle(color: Colors.white),
          //         );
          //       }),
          //     ),
          //     child: const Icon(
          //       Icons.shopping_cart_sharp,
          //       color: Colors.black,
          //     ),
          //   )),
          // ),
          // SizedBox(
          //   width: 20,
          // ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            bloc: widget.bloc,
                          )));
            },
            child: Center(
                child: Badge(
              badgeContent: StreamBuilder<int>(
                stream: widget.bloc.addedCounterStream,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  print(data);
                  if (snapshot.hasData) {
                    return Text(
                      data.toString(),
                      style: TextStyle(color: Colors.white),
                    );
                  }
                  return Container();
                },
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
        child: Column(
          children: [
            // IconButton(onPressed: widget.bloc.plus, icon: Icon(Icons.add)),
            // IconButton(onPressed: widget.bloc.del, icon: Icon(Icons.remove)),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              widget.data[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await widget.bloc.addItem(
                                    Data(
                                      userId: widget.data[index].userId,
                                      id: widget.data[index].id,
                                      title:
                                          widget.data[index].title.toString(),
                                      quantity: 1,
                                      //uniqueId: widget.data[index].uniqueId,
                                    ),
                                  );

                                  // context.read<CartProvider>().addCounter();
                                  widget.bloc.plus();
                                },
                                child: const Text("Add To Cart"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await widget.bloc.removeItem(
                                    Data(
                                      userId: widget.data[index].userId,
                                      id: widget.data[index].id,
                                      title:
                                          widget.data[index].title.toString(),
                                      quantity: 1,
                                      //uniqueId: widget.data[index].uniqueId,
                                    ),
                                  );
                                  //context.read<CartProvider>().removeCounter();
                                  widget.bloc.del();
                                  Navigator.pop(context);
                                },
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
                                      widget.data[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                  ),
                                  // SizedBox(20),
                                  RawMaterialButton(
                                    onPressed: () async {
                                      await widget.bloc.addItem(Data(
                                        userId: widget.data[index].userId,
                                        id: widget.data[index].id,
                                        title:
                                            widget.data[index].title.toString(),
                                        quantity: 1,
                                        //uniqueId: widget.data[index].uniqueId,
                                      ));
                                      widget.bloc.plus();
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
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
