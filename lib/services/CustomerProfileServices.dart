import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/CustomerProfile.dart';

class CustomerProfileServices {

  static final String GET_CUSTOMER_PROFILE_SERVICE = "https://swp490spa.herokuapp.com/api/customer/getprofile?userId=";

  static Future<CustomerProfile> getCustomerProfile() async {
    try{
      final response = await http.get(GET_CUSTOMER_PROFILE_SERVICE+MyApp.storage.getItem("customerId").toString(),
          headers: {
        "authorization": "Bearer " + MyApp.storage.getItem("token"),
      });
      print(response.statusCode);
      if(200 == response.statusCode){
        print (utf8.decode(response.bodyBytes));
        final CustomerProfile customerProfile = customerProfileFromJson(utf8.decode(response.bodyBytes));

        return customerProfile;
      }else{
        return CustomerProfile();
      }
    }catch(e){
      return CustomerProfile();
    }
  }
}