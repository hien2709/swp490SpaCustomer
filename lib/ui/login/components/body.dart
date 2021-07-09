import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/bottom_navigation/bottom_navigation.dart';
import 'package:spa_customer/ui/components/form_error.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';
import 'package:spa_customer/ui/sign_up/sign_up.dart';

class Body extends StatelessWidget {
  final bool isMainLogin;

  const Body({Key key, @required this.isMainLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                Text(
                  "Chào mừng bạn trở lại",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: SizeConfig.getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(isMainLogin: isMainLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignForm extends StatefulWidget {
  final bool isMainLogin;

  const SignForm({
    Key key,
    @required this.isMainLogin,
  }) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String password;
  final List<String> errors = [];

  void onClickSignIn(String phoneNumber, String password) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }

    String url = "https://swp490spa.herokuapp.com/api/public/login";

    var jsonResponse;
    final res = await http.post(url,
        headers: {
          "accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode({
          "phone": phoneNumber,
          "password": password,
          "role": "CUSTOMER"
        }));
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);

      print(phoneNumber + password);
      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");

      if (jsonResponse != null) {
        setState(() {
          isLoading = false;
        });
        if (jsonResponse['errorMessage'] == null) {
          MyApp.storage.setItem("token", jsonResponse['jsonWebToken']);
          MyApp.storage.setItem("customerId", jsonResponse['idAccount']);
          widget.isMainLogin
              ? Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavigation()),
                )
              : Navigator.pop(
                  context,
                );
        } else {
          print(jsonResponse['errorMessage']);
          if (jsonResponse['errorCode'] == 1 &&
              !errors.contains(kWrongPhoneNumberError)) {
            errors.add(kWrongPhoneNumberError);
          }
          if (jsonResponse['errorCode'] == 2 &&
              !errors.contains(kInvalidPasswordError)) {
            errors.add(kInvalidPasswordError);
            errors.remove(kWrongPhoneNumberError);
          }
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });

      print("Response status ????:  ${res.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneFormField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Text(
              "QUÊN MẬT KHẨU?",
              textAlign: TextAlign.right,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 20),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          DefaultButton(
            text: "Đăng nhập",
            press: () {
              onClickSignIn(phoneNumber, password);
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Chưa có tài khoản?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                ),
                child: Text(
                  "Đăng ký ngay.",
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        phoneNumber = value;
        if (value.isNotEmpty && errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.remove(kPhoneNumberNullError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPhoneNumberNullError)) {
          setState(() {
            errors.add(kPhoneNumberNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Số điện thoại",
          hintText: "Nhập số điện thoại",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.phone)),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        password = value;
        if (value.isNotEmpty && errors.contains(kPasswordNullError)) {
          setState(() {
            errors.remove(kPasswordNullError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kPasswordNullError)) {
          setState(() {
            errors.add(kPasswordNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Mật khẩu",
          hintText: "Nhập mật khẩu",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }
}
