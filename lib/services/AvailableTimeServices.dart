import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/AvailableTime.dart';

class AvailableTimeServices {
  static final String GET_AVAILABLE_TIME_FOR_BOOKING = "https://swp490spa.herokuapp.com/api/customer/getlisttimebook?";

  static Future<AvailableTime> getAvailableTimeForBooking(int packageId, String dateBooking, int spaId) async{
    try{
      final response = await http.get(GET_AVAILABLE_TIME_FOR_BOOKING+"customerId=${MyApp.storage.getItem("customerId")}"+"&dateBooking=${dateBooking}&spaId=${spaId}&spaPackageId=${packageId}",
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print("status code ne : "+response.statusCode.toString());
      if(200 == response.statusCode){
        print (utf8.decode(response.bodyBytes));
        final AvailableTime availableTime = availableTimeFromJson(utf8.decode(response.bodyBytes));

        return availableTime;
      }else{
        return AvailableTime();
      }
    }catch(e){
      return AvailableTime();
    }
  }
}