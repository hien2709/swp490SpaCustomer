import 'package:flutter/material.dart';
import 'package:spa_customer/services/CustomerProfileServices.dart';
import 'package:spa_customer/ui/components/profile_pic.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

import '../../../../main.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            //Text(MyApp.storage.getItem("email"), textAlign: TextAlign.center),
            SizedBox(height: 40),
            ChangePasswordForm(),
          ],
        ),
      ),
    );
  }
}

class ChangePasswordForm extends StatefulWidget {
  @override
  _ChangePasswordFormState createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  TextEditingController oldPasswordTextController = TextEditingController();
  TextEditingController newPasswordTextController = TextEditingController();
  TextEditingController confirmPasswordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OldPasswordTextField(),
            SizedBox(height: 30),
            NewPasswordTextField(),
            SizedBox(height: 30),
            ConfirmPasswordTextField(),
            SizedBox(height: 30),
            buildUpdateButton(context),
          ],
        ),
      ),
    );
  }

  int validate() {
    if (oldPasswordTextController.text != MyApp.storage.getItem('password')) {
      print("Mật khẩu không đúng");
      return 1;
    } else if (newPasswordTextController.text != confirmPasswordTextController.text || newPasswordTextController.text == "" || confirmPasswordTextController.text == "") {
      print("2 mật khẩu không giống nhau ");
      return 2;
    }
    return 0;
  }

  TextFormField OldPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: oldPasswordTextController,
      decoration: InputDecoration(
        labelText: "Mật khẩu cũ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField NewPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: newPasswordTextController,
      decoration: InputDecoration(
        labelText: "Mật khẩu mới",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField ConfirmPasswordTextField() {
    return TextFormField(
      obscureText: true,
      controller: confirmPasswordTextController,
      decoration: InputDecoration(
        labelText: "Nhập lại mật khẩu",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  DefaultButton buildUpdateButton(BuildContext context) {
    return DefaultButton(
      text: "Cập nhật",
      press: () async {
        if(validate() == 0){
          print("Đổi mật khẩu thành công");
          final snackBar = SnackBar(
            content: Text('Đổi mật khẩu thành công'),
            action: SnackBarAction(
              label: 'Tắt',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          final res = await CustomerProfileServices().editCustomerPassword(
              newPasswordTextController.text);
          print(res.body);
          setState(() {
            MyApp.storage.setItem("password", newPasswordTextController.text);
            oldPasswordTextController.clear();
            newPasswordTextController.clear();
            confirmPasswordTextController.clear();
          });

        }
        else if(validate() == 1){
          print("Không thể đổi mật khẩu");
          final snackBar = SnackBar(
            content: Text('Nhập sai mật khẩu hiện tại'),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        else if(validate() == 2){
          final snackBar = SnackBar(
            content: Text('Nhập lại mật khẩu mới'),
            action: SnackBarAction(
              label: 'Thử lại',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }


      },
    );
  }
}
