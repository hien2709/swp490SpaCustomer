import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/CustomerProfile.dart';
import 'package:spa_customer/services/CustomerProfileServices.dart';
import 'package:spa_customer/ui/login/components/default_button.dart';

import '../../../main.dart';
import '../profile_detail.dart';


class ProfileForm extends StatefulWidget {
  bool edit;
  bool enableDropDown;


  ProfileForm(this.edit, this.enableDropDown);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  CustomerProfile customerProfile;
  String genderChoose;
  DateTime selectedDate;
  bool loading = true;

  TextEditingController fullnameTextController = TextEditingController();
  TextEditingController districtTextController = TextEditingController();
  TextEditingController dateOfBirthTextController = TextEditingController();
  TextEditingController genderTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  void fillText() {
    fullnameTextController =
        TextEditingController(text: customerProfile.data.user.fullname);
    districtTextController =
        TextEditingController(text: customerProfile.data.user.address);
    genderTextController =
        TextEditingController(text: customerProfile.data.user.gender);
    dateOfBirthTextController =
        TextEditingController(text: customerProfile.data.user.birthdate.toString().substring(0,10));
    phoneTextController =
        TextEditingController(text: customerProfile.data.user.phone);
    emailTextController =
        TextEditingController(text: customerProfile.data.user.email);
  }

  getData() async {
    await CustomerProfileServices.getCustomerProfile().then((value) => {
      setState(() {
        customerProfile = value;
        loading = false;
      })
    });
  }

   validate(email, name, address){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    bool check = true;
    if(!emailValid){
      final snackBar = SnackBar(
        content: Text('Email sai format'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      check = false;
      return check;
    }
    if(name.toString().trim() == ""){
      final snackBar = SnackBar(
        content: Text('Vui lòng nhập tên'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      check = false;
      return check;
    }
    if(address.toString().trim() == ""){
      final snackBar = SnackBar(
        content: Text('Vui lòng nhập địa chỉ'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      check = false;
      return check;
    }
    return check;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Center(
          child: SpinKitWave(
            color: kPrimaryColor,
            size: 50,
          )
      );
    }else{
      fillText();
      return Container(
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FullNameTextField(),
              SizedBox(height: 20),
              EmailTextField(),
              SizedBox(height: 20),
              BirthDateTextField(),
              SizedBox(height: 20),
              GenderField(),
              SizedBox(height: 20),
              PhoneTextField(),
              SizedBox(height: 20),
              DistrictTextField(),
              SizedBox(height: 20),
              buildUpdateButton(context),
            ],
          ),
        ),
      );
    }

  }

  DefaultButton buildUpdateButton(BuildContext context) {
    return DefaultButton(
      text: "Cập nhật",
      press: () async {
        if(validate(emailTextController.text, fullnameTextController.text, districtTextController.text)){
          final res = await CustomerProfileServices().updateCustomerProfile(
            token: MyApp.storage.getItem("token"),
            active: true,
            address: districtTextController.text,
            birthdate: dateOfBirthTextController.text,
            email: emailTextController.text,
            fullname: fullnameTextController.text,
            gender: genderTextController.text,
            id: MyApp.storage.getItem("customerId"),
            image: customerProfile.data.user.image,
            password: customerProfile.data.user.password,
            phone: phoneTextController.text,
          );
          print("Status: ${res.body}");
          if(res.statusCode == 200){
            print("update thành công");
          }
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileDetail()),
          );
        };
        }


    );
  }

  TextFormField FullNameTextField() {
    return TextFormField(
      controller: fullnameTextController,
      enabled: widget.edit,
      decoration: InputDecoration(
        labelText: "Tên",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.drive_file_rename_outline),
      ),
    );
  }

  TextFormField EmailTextField() {
    return TextFormField(
      controller: emailTextController,
      enabled: widget.edit,
      decoration: InputDecoration(
        labelText: "Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.mail),
      ),
    );
  }

  TextFormField BirthDateTextField() {
    return TextFormField(
      controller: dateOfBirthTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Ngày sinh",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.baby_changing_station),
      ),
    );
  }

  TextFormField DistrictTextField() {
    return TextFormField(
      controller: districtTextController,
      enabled: widget.edit,
      minLines: 1,
      maxLines: 4,
      decoration: InputDecoration(
        labelText: "Địa chỉ",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.edit_road),
      ),
    );
  }

  Widget GenderField() {
    return TextFormField(
      controller: genderTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Giới tính",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.support_agent),
      ),
    );
  }

  TextFormField PhoneTextField() {
    return TextFormField(
      controller: phoneTextController,
      enabled: false,
      decoration: InputDecoration(
        labelText: "Số điện thoại",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

}
