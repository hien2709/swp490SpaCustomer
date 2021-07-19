import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/models/ConsultantProfileToChat.dart';
import 'package:spa_customer/services/ConsultantProfileServices.dart';
import 'package:spa_customer/services/firebase_service.dart';

import '../../../main.dart';
import 'chat_card.dart';


class Body extends StatefulWidget {

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Stream chatRoomStream;
  FirebaseMethod firebaseMethod = FirebaseMethod();
  bool loading = true;
  QuerySnapshot searchResult;
  TextEditingController searchInput = TextEditingController();
  bool isSearch = false;
  ConsultantProfileToChat consultantProfileToChat = ConsultantProfileToChat();
  String consultantName;
  String consultantPhone;
  String consultantImage;

  getChatRoom() async {
    await getListConsultantForChat();
    await createChatRoom();
    print("customerId: " + MyApp.storage.getItem("customerId").toString());
    await firebaseMethod.getChatRoomStream(MyApp.storage.getItem("customerId")).then((value) {
      setState(() {
        chatRoomStream = value;
        loading = false;
      });
    });
  }

  getListConsultantForChat() async{
    await ConsultantProfileServices.getConsultantProfileToChat(MyApp.storage.getItem("customerId"))
        .then((value) => {
      setState(() {
        consultantProfileToChat = value;
        loading = false;
        print("Fullname: " + consultantProfileToChat.data[0].user.fullname);
      })
    });
  }

  createChatRoom() {
      for(int i = 0; i < consultantProfileToChat.data.length; i++){
      List<int> users = [MyApp.storage.getItem("customerId"), consultantProfileToChat.data[i].id];
      FirebaseMethod firebaseMethod = FirebaseMethod();
      String chatRoomId = "${MyApp.storage.getItem("customerId")}_${consultantProfileToChat.data[i].id}";
      Map<String, dynamic> chatRoom = {
        "users": users,
        "chatRoomId" : chatRoomId,
      };
      firebaseMethod.createChatRoom(chatRoomId, chatRoom );
    }
  }

  getConsultantInfo(consultantId){
    for(int i = 0; i < consultantProfileToChat.data.length; i++){
      if(consultantProfileToChat.data[i].user.id == consultantId){
        consultantName = consultantProfileToChat.data[i].user.fullname;
        consultantPhone = consultantProfileToChat.data[i].user.phone;
        consultantImage = consultantProfileToChat.data[i].user.image;
      }
    }
  }

  Widget searchList() {
    return searchResult != null
        ? ListView.builder(
      shrinkWrap: true,
      itemCount: searchResult.docs.length,
      itemBuilder: (context, index) {
        return ChatCard(
          consultantId: searchResult.docs[index]["id"],
          chatRoomId: getChatRoomId(
              int.parse(searchResult.docs[index]["id"]),
              MyApp.storage.getItem("staffId")),
        );
      },
    )
        : Container();
  }

  getChatRoomId(int a, int b) {
    if (a > b) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget showChatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              String consultantId = snapshot
                  .data.docs[index]["chatRoomId"]
                  .toString()
                  .replaceAll("_", "")
                  .replaceAll("${MyApp.storage.getItem("customerId")}", "");
              getConsultantInfo(consultantId);
              return ChatCard(
                consultantId: consultantId,
                  chatRoomId:
                  snapshot.data.docs[index]["chatRoomId"],
                  consultantName:consultantName,
                  consultantPhone: consultantPhone,
                  consultantImage: consultantImage == null ? "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png" : consultantImage,
              );
            }
        )
            : Container();
      },
    );
  }

  searchButton() async {
    if (searchInput.text != "") {
      await firebaseMethod.getUserByUsername(searchInput.text).then((value) {
        setState(() {
          isSearch = true;
          searchResult = value;
        });
      });
    }
    return;
  }



  @override
  void initState() {
    super.initState();
    getChatRoom();
  }

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Center(
          child: SpinKitWave(
            color: Colors.orange,
            size: 50,
          )
      );
    }
    else{
      return Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  controller: searchInput,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      color: Colors.grey.shade400,
                      iconSize: 25,
                      onPressed: () {
                        searchButton();
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade100)),
                  ),
                ),
              ),
              isSearch ? searchList() : showChatRoomList(),
            ],
          ),
        ),
      );
    }
  }
}
