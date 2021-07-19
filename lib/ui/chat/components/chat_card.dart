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


  @override
  Widget build(BuildContext context) {

      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ConversationScreen(
                        chatRoomId: widget.chatRoomId,
                        consultantPhone: widget.consultantPhone,
                        consultantName: widget.consultantName,
                        consultantImage: widget.consultantImage,
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
                      backgroundImage: NetworkImage(widget.consultantImage),
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
                              widget.consultantName,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              widget.consultantPhone,
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
