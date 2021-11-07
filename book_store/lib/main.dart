import 'package:book_store/screen/add_to_card.dart';
import 'package:book_store/screen/card_list.dart';
import 'package:book_store/screen/home.dart';
import 'package:book_store/screen/order.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      initialRoute: '/home',
      routes: {
        '/home': (context) => home(),
        '/addToCard': (context) => AddToCard(),
        '/card_list': (context) => CardList(),
        '/order': (context) => Order()
      },
    );
  }
}
