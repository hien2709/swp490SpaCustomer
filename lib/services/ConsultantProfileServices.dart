import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/models/ConsultantProfileToChat.dart';

import '../main.dart';

class ConsultantProfileServices {

  static final String GET_CONSULTANT_PROFILE_TO_CHAT = "https://swp490spa.herokuapp.com/api/customer/getListConsultantForChat?customerId=";

  static Future<ConsultantProfileToChat> getConsultantProfileToChat(customerId) async {
    try{
      final response = await http.get(GET_CONSULTANT_PROFILE_TO_CHAT + customerId.toString(),
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print("Status: " + response.statusCode.toString());
      if(200 == response.statusCode){
        final ConsultantProfileToChat consultantProfileToChat = consultantProfileToChatFromJson(utf8.decode(response.bodyBytes));
        return consultantProfileToChat;
      }else{
        return ConsultantProfileToChat();
      }
    }catch(e){
      return ConsultantProfileToChat();
    }
  }
}