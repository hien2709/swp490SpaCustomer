import 'package:flutter/material.dart';
import 'package:spa_customer/ui/components/profile_pic.dart';
import 'package:spa_customer/ui/profile_detail/components/profile_form.dart';

import '../../../main.dart';

class Body extends StatelessWidget {

  bool edit;
  bool enableDropDown;


  Body(this.edit, this.enableDropDown);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfilePic(),
            SizedBox(height: 20),
            // Text(MyApp.storage.getItem("email"),
            //     textAlign: TextAlign.center),
            SizedBox(height: 40),
            ProfileForm(edit, enableDropDown),
          ],
        ),
      ),
    );
  }
}

