import 'package:flutter/material.dart';
import 'package:spa_customer/ui/profile_detail/components/body.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key key}) : super(key: key);

  @override
  _ProfileDetailState createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  bool edit = false;
  bool enableDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (edit) {
                    edit = false;
                    enableDropDown = false;
                  } else {
                    edit = true;
                    enableDropDown = true;
                  }
                });
              },
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Body(edit, enableDropDown),
    );
  }
}
