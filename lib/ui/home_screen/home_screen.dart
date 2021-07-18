import 'package:flutter/material.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/ui/home_screen/components/body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static List<PackageInstance> cart = new List<PackageInstance>();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("Item trong cart : ");
    print(MyApp.storage.getItem("cart"));

    return Scaffold(
      body: BodyHomeScreen(),
    );
  }
}
