import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/PutResponse.dart';

class GeneralServices {
  static final String EDIT_RATING =
      "https://swp490spa.herokuapp.com/api/customer/rating/edit";

  static Future<PutResponse> editRating(int staffId, int ratingId, String comment, double rate) async {
    final res = await http.put(EDIT_RATING,
        headers: {
          "accept": "application/json",
          "content-type": "application/json",
          "authorization": "Bearer " + MyApp.storage.getItem("token"),
        },
        body: jsonEncode({
          "staffId": staffId,
          "ratingId": ratingId,
          "comment": comment,
          "rate": rate,
        }));
    if (res.statusCode == 200) {
      PutResponse response;
      response = putResponseFromJson(utf8.decode(res.bodyBytes));
      print(response.code.toString() +" "+ response.data);
      return response;
    } else {
      print("LOI ROI" + "Status code = " + res.statusCode.toString());
    }

  }
}
