import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'conversation_screen.dart';

class ChatCard extends StatefulWidget {
  String consultantId = "";
  String chatRoomId = "";
  String consultantImage = "";
  String consultantName = "";
  String consultantPhone = "";


  ChatCard(
      {this.consultantId,
      this.chatRoomId,
      this.consultantImage,
      this.consultantName,
      this.consultantPhone});

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {

  bool loading = true;
  String consultantName;
  String consultantPhone;
  String consultantImage;


  @override
  void initState() {
    super.initState();
    getStaffInfo();
  }


  getStaffInfo() async {
    consultantName = widget.consultantName;
    consultantPhone = widget.consultantPhone;
    consultantImage = widget.consultantImage;
    loading = false;
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
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ConversationScreen(
                        chatRoomId: widget.chatRoomId,
                        phone: consultantPhone,
                        name: consultantName,
                        image: consultantImage,
                      )
              ));
        },
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(consultantImage),
                      maxRadius: 30,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              consultantName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              consultantPhone,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

  }
}
