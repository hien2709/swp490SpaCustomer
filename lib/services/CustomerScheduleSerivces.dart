import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/CustomerSchedule.dart';

class CustomerScheduleServices{
  static final String GET_BOOKING_SCHEDULE_BY_CUSTOMER_ID = "https://swp490spa.herokuapp.com/api/customer/getScheduleBooking/";

  static Future<CustomerSchedule> getCustomerSchedule() async {
    try{
      final response = await http.get(GET_BOOKING_SCHEDULE_BY_CUSTOMER_ID+MyApp.storage.getItem("customerId").toString(),
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print(response.statusCode);
      if(200 == response.statusCode){
        print (utf8.decode(response.bodyBytes));
        final CustomerSchedule customerSchedule = customerScheduleFromJson(utf8.decode(response.bodyBytes));

        return customerSchedule;
      }else{
        return CustomerSchedule();
      }
    }catch(e){
      print(e);
      return CustomerSchedule();
    }
  }
}