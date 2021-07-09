import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/models/Category.dart';

class CategoryServices{
  static final String GET_ALL_CATEGORY = "https://swp490spa.herokuapp.com/api/public/category/findall?status=AVAILABLE";

  static Future<Category> getAllCategory() async{
    try{
      final response = await http.get(GET_ALL_CATEGORY);
      print(response.statusCode);
      if(200 == response.statusCode){
        print (utf8.decode(response.bodyBytes));
        final Category category = categoryFromJson(utf8.decode(response.bodyBytes));
        return category;
      }else{
        return Category();
      }
    }catch(e){
      return Category();
    }
  }
}