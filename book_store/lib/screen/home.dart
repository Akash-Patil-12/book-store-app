import 'dart:async';
//import 'dart:convert';

import 'package:book_store/model/books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final FocusNode _focusNode = FocusNode();
  String dropdownValue = 'Sort by relevance';
  List<Book> bookData = [];
  List<Book> allBookData = [];
  int cardCount = 0;
  Future<void> getBookData() async {
    allBookData = await readBookJson(); ////change name...
    print(bookData);
    int count = await getCardCount();
    setState(() {
      bookData = allBookData;
      cardCount = count;
    });
    print('*******************************************************');
    print(cardCount);
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
              child: Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          //   bookData = allBookData;
                          bookData = allBookData
                              .where((bookData) => bookData.title
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                          print("..........................");
                          print(bookData);
                        });
                      }
                      if (value.isEmpty) {
                        print('..........else..........');
                        setState(() {
                          bookData = allBookData;
                        });
                      }
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(2),
                        hintText: "Search...",
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _focusNode.hasFocus
                                    ? Colors.grey.shade600
                                    : Colors.grey.shade500))),
                  ))),
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
                  child: Text(cardCount.toString(),
                      style: const TextStyle(fontSize: 15, color: Colors.red)),
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
      body: bookData.isEmpty
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
                            if (newValue == "Price: Low to High") {
                              print('>>>>>>>>>>>>>>>>>>>>>>>>');
                              bookData.sort((a, b) {
                                return a.price.compareTo(b.price);
                              });
                              print(bookData);
                            }
                            if (newValue == "Price: High to Low") {
                              print('>>>>>>>>>>>>>>>>>>>>>>>>');
                              //bookData.sort();
                              bookData
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
                        itemCount: bookData.length,
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
                                              bookData[index].image,
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
                                          Text(bookData[index].title,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            "by " + bookData[index].author,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey),
                                          ),
                                          Text("Rs." + bookData[index].price,
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
                                                onPressed: () {
                                                  setState(() {
                                                    cardCount = cardCount + 1;
                                                  });
                                                  Map<String, dynamic>
                                                      bookCardData = {
                                                    "id": bookData[index].id,
                                                    "image":
                                                        bookData[index].image,
                                                    "title":
                                                        bookData[index].title,
                                                    "author":
                                                        bookData[index].author,
                                                    "price":
                                                        bookData[index].price,
                                                  };
                                                  FirebaseFirestore.instance

                                                      ///create new method
                                                      .collection("Add-To-Card")
                                                      .add(bookCardData);
                                                },
                                              ),
                                              TextButton(
                                                child: const Text(
                                                  'WISHLIST',
                                                  style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.black),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        color: Colors.black),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  )),
                                                ),
                                                onPressed: () {},
                                              ),
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
