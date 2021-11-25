import 'dart:convert';

import 'package:book_store/model/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

Future<List<Book>> readBookListFromJsonFile() async {
  List<Book> bookData = [];
  final String response = await rootBundle.loadString('assets/books.json');
  var data = json.decode(response);
  for (var bookjson in data) {
    bookData.add(Book.fromJson(bookjson));
  }
  return bookData;
}

addToCardBook(Map<String, dynamic> book) {
  FirebaseFirestore.instance.collection("Add-To-Card").add(book);
}
