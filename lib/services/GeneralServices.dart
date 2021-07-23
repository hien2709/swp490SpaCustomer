import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';

class GeneralServices {
  static final String EDIT_RATING =
      "https://swp490spa.herokuapp.com/api/customer/rating/edit";

  static Future<String> editRating(int staffId, int ratingId, String comment, double rate) async {
    var jsonResponse;
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
      jsonResponse = utf8.decode(res.bodyBytes);
      print(jsonResponse.toString());
    } else {
      print("LOI ROI" + "Status code = " + res.statusCode.toString());
    }
    return res.statusCode.toString();
  }
}
