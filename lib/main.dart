import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:spa_customer/theme.dart';
import 'package:spa_customer/ui/bottom_navigation/bottom_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final LocalStorage storage = new LocalStorage('localstorage_app');
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(MyApp.storage.getItem("token"));
    print(MyApp.storage.getItem("cart"));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spa & Beauty',
      theme: theme(),
      home: BottomNavigation(),
    );
  }
}
