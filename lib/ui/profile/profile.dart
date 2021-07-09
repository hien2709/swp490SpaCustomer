import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/ui/login/login.dart';
import 'package:spa_customer/ui/profile/components/body.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyApp.storage.getItem("token") == null
          ? Login()
          : CustomerProfileWidget(),
    );
  }
}

class CustomerProfileWidget extends StatelessWidget {
  const CustomerProfileWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Tài khoản",
          style: TextStyle(
            color: kTextColor
          ),
        ),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
