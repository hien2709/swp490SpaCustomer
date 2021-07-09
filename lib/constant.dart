import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFA53E), Color(0xFFFF7643)]
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kBackgroundColor = Color(0xFFf2f2f2);
const kYellow = Color(0xFFffcc00);
const kGreen = Color(0xFF4cd963);
const kBlue = Color(0xFF5ac7cd);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
    fontSize: 28,
    fontWeight:FontWeight.bold,
    color: Colors.black,
    height: 1.5
);

const String kPhoneNumberNullError = "Bạn chưa nhập số điện thoại";
const String kFullnameNullError = "Bạn chưa nhập họ và tên";
const String kWrongPhoneNumberError = "Số điện thoại không đúng";
const String kPasswordNullError = "Bạn chưa nhập mật khẩu";
const String kInvalidPasswordError = "Mật khẩu không đúng";
const String kInvalidConfirmPasswordError = "Mật khẩu nhập lại không trùng khớp";
const String kNullConfirmPasswordError = "Bạn chưa nhập lại mật khẩu";