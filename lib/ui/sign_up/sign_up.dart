import 'package:flutter/material.dart';
import 'package:spa_customer/ui/sign_up/components/body.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
