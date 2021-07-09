import 'package:flutter/material.dart';
import 'package:spa_customer/ui/login/components/body.dart';

class Login extends StatelessWidget {
  const Login({Key key, this.isMainLogin}) : super(key: key);
  final bool isMainLogin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng nhập"),
        centerTitle: true,
      ),
      body: Body(isMainLogin: isMainLogin),
    );
  }
}
