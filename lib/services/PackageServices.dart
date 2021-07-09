import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/models/Package.dart';

class PackageServices {
  static final String GET_ALL_PACKAGES = "https://swp490spa.herokuapp.com/api/public/getallspapackage";

  static Future<Package> getAllPackages() async {
    try{
      final response = await http.get(GET_ALL_PACKAGES);
      print(response.statusCode);
      if(response.statusCode == 200){
        print (utf8.decode(response.bodyBytes));
        final Package packages = packageFromJson(utf8.decode(response.bodyBytes));

        return packages;
      }else{
        return Package();
      }
    }catch(e){
      return Package();
    }
  }
}