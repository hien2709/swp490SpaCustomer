import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:spa_customer/services/firebase_service.dart';

import 'conversation_screen.dart';

class ChatCard extends StatefulWidget {
  String staffId = "";
  String chatRoomId = "";

  ChatCard({this.staffId, this.chatRoomId});

  @override
  _ChatCardState createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  String staffName;
  String staffPhone;
  String staffImage;
  bool loading = true;



  @override
  void initState() {
    super.initState();
    getStaffInfo();
  }


  getStaffInfo() async {
    staffName = "Nguyễn Toàn Thắng";
    staffPhone = "097";
    staffImage = "https://static2.yan.vn/YanNews/2167221/201908/linh-ka-dap-tra-xeo-sac-khi-bi-noi-don-nguc-c95f3626.jpg";
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
                        phone: staffPhone,
                        name: staffName,
                        image: staffImage,
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
                      backgroundImage: NetworkImage(staffImage),
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
                              staffName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              staffPhone,
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
