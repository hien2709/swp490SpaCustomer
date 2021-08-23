import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/services/firebase_service.dart';
import 'package:spa_customer/ui/components/form_error.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';
import 'package:spa_customer/ui/sign_up/components/otp.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Đăng ký tài khoản",
                style: headingStyle,
              ),
              SizedBox(height: 10),
              Text("điền những thông tin của bạn \nvào phần bên dưới",
                  textAlign: TextAlign.center
              ),
              SizedBox(height: 40),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String fullname;
  String password;
  String confirmPassword;
  final List<String> errors = [];

  void onClickSignUp(String fullname, String phoneNumber, String password) async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
    }

    String url = "https://swp490spa.herokuapp.com/api/public/register";
    var jsonResponse;
    final res = await http.post(url,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json"
        }
        ,
        body: jsonEncode({
          "fullname": fullname,
          "password": password,
          "phone": phoneNumber
        }));
    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");



      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpScreen(phone: phoneNumber,)),
      );
    }else{
      print("Response status ????:  ${res.body}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildFullnameFormField(),
          SizedBox(height: 40),
          buildPhoneFormField(),
          SizedBox(height: 40),
          buildPasswordFormField(),
          SizedBox(height: 40),
          buildConfirmPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: 40),
          DefaultButton(
            text: "Tiếp tục",
            press: () {
              onClickSignUp(fullname, phoneNumber, password);
            },
          ),

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

  TextFormField buildFullnameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        fullname = value;
        if (value.isNotEmpty && errors.contains(kFullnameNullError)) {
          setState(() {
            errors.remove(kFullnameNullError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kFullnameNullError)) {
          setState(() {
            errors.add(kFullnameNullError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Họ và tên",
          hintText: "Nhập họ và tên",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.person_outline)),
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
        password = value;
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
  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNullConfirmPasswordError)) {
          setState(() {
            errors.remove(kNullConfirmPasswordError);
          });
        }
        if (value == password && errors.contains(kInvalidConfirmPasswordError)) {
          setState(() {
            errors.remove(kInvalidConfirmPasswordError);
          });
        }
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(kNullConfirmPasswordError)) {
          setState(() {
            errors.add(kNullConfirmPasswordError);
          });
        }else if(!(value == password) && !errors.contains(kInvalidConfirmPasswordError)){
          setState(() {
            errors.add(kInvalidConfirmPasswordError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Xác minh mật khẩu",
          hintText: "Nhập lại mật khẩu",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.lock_outline)),
    );
  }
}

