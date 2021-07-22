import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spa_customer/services/CustomerProfileServices.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';
import 'package:async/async.dart';

import '../../main.dart';


class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  File imageFile;
  String image;

  void takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker.pickImage(source: source);
    setState(() {
      imageFile = pickedFile;
      print("imageFilePath: " + imageFile.path);
    });
    uploadFile(imageFile);
  }

  getCustomerProfile() async{
    await CustomerProfileServices.getCustomerProfile().then((value) => {
      setState(() {
        image = value.data.user.image;
      })
    });
  }

  uploadFile(File imageFile) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();
    // string to uri
    var uri = Uri.parse(
        "https://swp490spa.herokuapp.com/api/customer/image/edit/" + MyApp.storage.getItem("customerId").toString());
    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);
    request.headers.addAll({
      "Content-type": "multipart/form-data",
      "Authorization": "Bearer " + MyApp.storage.getItem("token"),
    });
    // multipart that takes file
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);
    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  @override
  void initState() {
    super.initState();
    getCustomerProfile();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            backgroundImage: imageFile == null
                ? NetworkImage(image == null ? "https://thinkingschool.vn/wp-content/uploads/avatars/753/753-bpfull.jpg" : image)
                : FileImage(File(imageFile.path)),
          ),
          Positioned(
            bottom: 0,
            right: -10,
            child: SizedBox(
              height: 50,
              width: 50,
              child: FlatButton(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white)),
                onPressed: () {
                  print("Update image profile");
                  showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet()),
                  );
                },
                color: Color(0xFFF5F6F9),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(this.context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.camera);
                  print("Chụp xong rồi!!");
                },
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              FlatButton.icon(
                onPressed: () async {
                  await takePhoto(ImageSource.gallery);
                  print("Chụp xong rồi!!");
                },
                icon: Icon(Icons.image),
                label: Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
