import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/models/Spa.dart';

class SpaServices{
  static final String GET_ALL_SPA = "https://swp490spa.herokuapp.com/api/public/spa/findAll";

  static Future<Spa> getAllCategory() async{
    try{
      final response = await http.get(GET_ALL_SPA);
      print(response.statusCode);
      if(200 == response.statusCode){
        print (utf8.decode(response.bodyBytes));
        final Spa spa = spaFromJson(utf8.decode(response.bodyBytes));
        return spa;
      }else{
        return Spa();
      }
    }catch(e){
      return Spa();
    }
  }
}