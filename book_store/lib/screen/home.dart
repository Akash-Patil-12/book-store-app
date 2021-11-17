import 'dart:async';
import 'package:book_store/componant/search_controller.dart';
import 'package:book_store/componant/wishlist_controller.dart';
import 'package:book_store/controller/card_count.dart';
import 'package:book_store/model/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final cardCountController = Get.put(CardCountController());
  String dropdownValue = 'Sort by relevance';
  List<Book> bookListData = [];
  List<Book> filterBookListData = [];
  //int cardCount = 0;
  Future<void> getBookData() async {
    filterBookListData = await readBookListFromJsonFile();
    print(bookListData);
    // int count = await getCardCount();
    setState(() {
      bookListData = filterBookListData;
      //cardCount = count;
    });
    print('*******************************************************');
    // print(cardCount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        title: Row(children: [
          //Text('Bookstore'),
          Expanded(
              child: SearchController(
            hintText: "Search..",
            searchTextfieldCallBack: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  //   bookData = allBookData;
                  bookListData = filterBookListData
                      .where((bookData) => bookData.title
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  print("..........................");
                  print(bookListData);
                });
              }
              if (value.isEmpty) {
                print('..........else..........');
                setState(() {
                  bookListData = filterBookListData;
                });
              }
              print(
                  ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
              print(value);
            },
          )),
        ]),
        actions: [
          Stack(
            children: [
              Positioned(
                height: 250,
                width: 250,
                child: Container(
                  width: 150,
                  height: 150,
                  child:
                      // Text(cardCount.toString(),
                      //     style: const TextStyle(fontSize: 15, color: Colors.red))
                      GetX<CardCountController>(builder: (controller) {
                    return Text(controller.cardCount.toString(),
                        style:
                            const TextStyle(fontSize: 15, color: Colors.red));
                  }),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/card_list');
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AddToCard()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: bookListData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Books",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            // if (newValue == "Sort by relevance") {
                            //   print('.......sort relevance...........');
                            //   print(filterBookListData);
                            //   setState(() {
                            //     bookListData = filterBookListData;
                            //   });
                            // }
                            if (newValue == "Price: Low to High") {
                              print('>>>>>>>>>>>low to high>>>>>>>>>>>>>');
                              // setState(() {

                              // });
                              bookListData
                                  .sort((a, b) => a.price.compareTo(b.price));
                              print(bookListData);
                            }
                            if (newValue == "Price: High to Low") {
                              print('>>>>>>>>>>High to low>>>>>>>>>>>>>>');
                              //bookData.sort();
                              bookListData
                                  .sort((b, a) => a.price.compareTo(b.price));
                            }
                          });
                        },
                        items: <String>[
                          'Sort by relevance',
                          'Price: Low to High',
                          'Price: High to Low'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                        itemCount: bookListData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.landscape
                              ? 4
                              : 2,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.grey[100],
                                      height: 72,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Image.asset(
                                              bookListData[index].image,
                                              height: 64,
                                              width: 70,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(bookListData[index].title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "by " + bookListData[index].author,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                              "Rs." +
                                                  bookListData[index]
                                                      .price
                                                      .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton(
                                                child: const Text(
                                                  'ADD TO BAG',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.white),
                                                ),
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.brown)),
                                                onPressed: () async {
                                                  //cardCountController
                                                  //  .getCardCount();
                                                  // setState(() {
                                                  //   cardCount = cardCount + 1;
                                                  // });
                                                  Map<String, dynamic>
                                                      bookCardData = {
                                                    "id":
                                                        bookListData[index].id,
                                                    "image": bookListData[index]
                                                        .image,
                                                    "title": bookListData[index]
                                                        .title,
                                                    "author":
                                                        bookListData[index]
                                                            .author,
                                                    "price": bookListData[index]
                                                        .price
                                                        .toString(),
                                                  };

                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection("Add-To-Card")
                                                      .add(bookCardData);
                                                  // Future.delayed(const Duration(
                                                  //     microseconds: 100));
                                                  cardCountController
                                                      .getCardCount();
                                                  var snackBar = const SnackBar(
                                                    content: Text(
                                                        "Book added to card"),
                                                    duration: Duration(
                                                        milliseconds: 250),
                                                  );
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(snackBar);
                                                },
                                              ),
                                              WishListController(
                                                wishListControllerCallBack:
                                                    (value) {
                                                  print(
                                                      '.................WishList.....................');
                                                  print(value);
                                                },
                                              ), ///////////////////////////
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
