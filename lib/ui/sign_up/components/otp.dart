import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:http/http.dart' as http;
import 'package:spa_customer/size_config.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';
import 'package:spa_customer/ui/login/login.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({Key key, this.phone}) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Xác thực OTP"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text("Xác thực OTP", style: headingStyle),
              Text("Chúng tôi đã gửi mã xác thực tới số ${widget.phone}"),
              buildTimer(),
              SizedBox(height: 40,),
              OtpForm(phone: widget.phone,),
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Mã xác thực sẽ hết hạn sau "),
        TweenAnimationBuilder(
            tween: Tween(begin: 30.0, end: 0),
            duration: Duration(minutes: 30),
            builder: (context, value, child) => Text(
              "00:${value.toInt()}",
              style: TextStyle(color: kPrimaryColor),
            )),
        Text(" phút"),
      ],
    );
  }
}

class OtpForm extends StatefulWidget {
  final String phone;

  const OtpForm({Key key, this.phone}) : super(key: key);
  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode pin1Focusnode;
  FocusNode pin2Focusnode;
  FocusNode pin3Focusnode;
  FocusNode pin4Focusnode;
  TextEditingController pin1;
  TextEditingController pin2;
  TextEditingController pin3;
  TextEditingController pin4;

  void onClickVerify(String otp, String phone) async{
    String url = "https://swp490spa.herokuapp.com/api/public/verifyregister";

    var jsonResponse;
    final res = await http.post(url,
        headers: {
          "accept" : "application/json",
          "content-type" : "application/json"
        }
        ,
        body: jsonEncode({
          "phone": phone,
          "otpCode": otp,
        }));
    if(res.statusCode == 200){
      jsonResponse = json.decode(res.body);

      print("Response status: ${res.statusCode}");
      print("Response body: ${res.body}");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Login(isMainLogin: true,)),
      );
    }else{
      print("Response status ????:  $jsonResponse");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pin1 = TextEditingController();
    pin2 = TextEditingController();
    pin3 = TextEditingController();
    pin4 = TextEditingController();
    pin1Focusnode = FocusNode();
    pin2Focusnode = FocusNode();
    pin3Focusnode = FocusNode();
    pin4Focusnode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pin1Focusnode.dispose();
    pin2Focusnode.dispose();
    pin3Focusnode.dispose();
    pin4Focusnode.dispose();
    pin1.dispose();
    pin2.dispose();
    pin3.dispose();
    pin4.dispose();
    super.dispose();
  }
  void nextField(String value, FocusNode focusNode){
    if(value.length == 1 || value.length==0){
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: pin1,
                  focusNode: pin1Focusnode,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                  ),
                  onChanged: (value){
                    value.length==1?nextField(value,pin2Focusnode):pin1Focusnode.unfocus();
                  }
                  ,
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                    controller: pin2,
                    focusNode: pin2Focusnode,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                    ),
                    onChanged: (value){
                      pin2.text=value;
                      value==""?nextField(value, pin1Focusnode):
                      nextField(value,pin3Focusnode);
                    }
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                    controller: pin3,
                    focusNode: pin3Focusnode,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: kTextColor),
                      ),
                    ),
                    onChanged: (value){
                      pin3.text=value;
                      value==""?nextField(value, pin2Focusnode):
                      nextField(value,pin4Focusnode);
                    }
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  controller: pin4,
                  focusNode: pin4Focusnode,
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: kTextColor),
                    ),
                  ),
                  onChanged: (value){
                    pin4.text=value;
                    value==""?nextField(value, pin3Focusnode):
                    pin4Focusnode.unfocus();
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.3,),
          DefaultButton(
            text: "Tiếp tục",
            press: (){
              print(pin1.text+pin2.text+pin3.text+pin4.text);
              onClickVerify(pin1.text+pin2.text+pin3.text+pin4.text, widget.phone);
            },
          ),
        ],
      ),
    );
  }
}
