import 'package:flutter/material.dart';
import 'package:spa_customer/ui/profile_detail/components/body.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Detail"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
