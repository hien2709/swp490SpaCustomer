import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/AllSpa.dart';
import 'package:spa_customer/models/CustomerProfile.dart';

class CustomerProfileServices {

  static final String GET_CUSTOMER_PROFILE_SERVICE = "https://swp490spa.herokuapp.com/api/customer/getprofile?userId=";
  static final String urlGetAllSpa = "https://swp490spa.herokuapp.com/api/public/spa/findAll";
  static final String urlEditPassword = "https://swp490spa.herokuapp.com/api/customer/editpassword";
  static final String urlUpdateProfile = "https://swp490spa.herokuapp.com/api/customer/user/edit";

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

  static Future<AllSpa> getAllSpa() async {
    try{
      final response = await http.get(urlGetAllSpa);
      print(response.statusCode);
      if(response.statusCode == 200){
        print (utf8.decode(response.bodyBytes));
        final AllSpa allSpa = allSpaFromJson(utf8.decode(response.bodyBytes));

        return allSpa;
      }else{
        return AllSpa();
      }
    }catch(e){
      return AllSpa();
    }
  }

  Future<http.Response> editCustomerPassword(password) {
    return http.put(
      Uri.parse(urlEditPassword),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${MyApp.storage.getItem("token")}',
      },
      body: jsonEncode(<String, dynamic>{
        "id": MyApp.storage.getItem("customerId"),
        "password": password,
      }),
    );
  }

  Future<http.Response> updateCustomerProfile({
    token,
    active,
    address,
    birthdate,
    email,
    fullname,
    gender,
    id,
    image,
    password,
    phone,
  }) {
    return http.put(
      Uri.parse(urlUpdateProfile),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "active": true,
        "address": address,
        "birthdate": birthdate,
        "email": email,
        "fullname": fullname,
        "gender": gender,
        "id": id,
        "image": image,
        "password": password,
        "phone": phone,
      }),
    );
  }

}