import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Book {
  String id;
  String image;
  String title;
  String author;
  String price;
  Book(
      {required this.id,
      required this.image,
      required this.title,
      required this.author,
      required this.price});
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
        id: json['id'] as String,
        image: json['image'] as String,
        title: json['title'] as String,
        author: json['author'] as String,
        price: json['price'] as String);
  }
}

Future<List<Book>> readBookJson() async {
  List<Book> bookData = [];
  final String response = await rootBundle.loadString('assets/books.json');
  var data = json.decode(response);
  for (var bookjson in data) {
    bookData.add(Book.fromJson(bookjson));
  }
  print('................................');
  print(bookData);
  return bookData;
}

Future<int> getCardCount() async {
  Query collectionReference =
      FirebaseFirestore.instance.collection('Add-To-Card');
  QuerySnapshot querySnapshot = await collectionReference.get();
  print('........CardCount...........');
  print(querySnapshot.docs.length);
  return querySnapshot.docs.length;
}
