

import 'package:flutter/material.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/Spa.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';
import 'package:spa_customer/ui/wish_list/components/wish_list_booking_body.dart';

class WishListBookingScreen extends StatefulWidget {
  final SpaInstance spa;
  const WishListBookingScreen({Key key, this.spa}) : super(key: key);

  @override
  _WishListBookingScreenState createState() => _WishListBookingScreenState();
}

class _WishListBookingScreenState extends State<WishListBookingScreen> {
  @override
  Widget build(BuildContext context) {
    MyApp.storage.getItem("cart") == null ? MyApp.storage.setItem("cart", cartItemToJson(new List<PackageInstance>())) :  HomeScreen.cart = cartItemFromJson(MyApp.storage.getItem("cart"));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Danh sách mong muốn",
              style: TextStyle(color: Colors.black),
            ),
            Text("4 Items", style: Theme.of(context).textTheme.caption,)
          ],
        ),
      ),
      body: WishListBookingBody(spa: widget.spa,),
    );
  }
}
