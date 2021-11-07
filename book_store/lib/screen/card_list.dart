//import 'dart:convert';

import 'package:book_store/model/books.dart';
//import 'package:book_store/screen/add_to_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  final FocusNode _focusNode = FocusNode();
  List<Book> cardData = [];
  late int cardCount = 0;

  Future<void> getCardDataCount() async {
    int count = await getCardCount();
    setState(() {
      cardCount = count;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardDataCount();
    //  getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown,
        leading: InkWell(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        title: Row(children: [
          //Text('Bookstore'),
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: TextField(
                    onChanged: (value) {
                      // if (value != " ") {
                      //   setState(() {
                      //     data = bookData
                      //         .where((bookData) => bookData['title']
                      //             .toString()
                      //             .toLowerCase()
                      //             .contains(value.toLowerCase()))
                      //         .toList();
                      //     print("..........................");
                      //     print(data);
                      //   });
                      // }
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
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AddToCard()));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined))
            ],
          )
        ],
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Add-To-Card').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Card is empty'),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, int index) {
                return InkWell(
                    child: Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            //width: double.infinity,
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                snapshot.data!.docs[index]['image'],
                                height: 70,
                                width: 70,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.docs[index]['title'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  "by " + snapshot.data!.docs[index]['author'],
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text(
                                    "Rs." + snapshot.data!.docs[index]['price'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            // SizedBox(
                            //   height: 30,
                            // ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextButton(
                                        child: const Text(
                                          'Remove From Card',
                                          style: TextStyle(
                                              fontSize: 9, color: Colors.white),
                                        ),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.brown)),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Add-To-Card')
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          setState(() {
                                            cardCount = cardCount - 1;
                                          });
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
                    onTap: () {
                      Navigator.pushNamed(context, '/addToCard', arguments: {
                        'id': snapshot.data!.docs[index].id,
                        'image': snapshot.data!.docs[index]['image'],
                        'title': snapshot.data!.docs[index]['title'],
                        'author': snapshot.data!.docs[index]['author'],
                        'price': snapshot.data!.docs[index]['price']
                      });
                    });
              });
        },
      ),
    );
  }
}
