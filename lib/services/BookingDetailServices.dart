import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/BookingDetail.dart';

class BookingDetailServices{
  static final String GET_BOOKING_DETAIL_MORE_STEP = "https://swp490spa.herokuapp.com/api/customer/bookingdetail/";
  static final String GET_BOOKING_DETAIL_BY_ID = "https://swp490spa.herokuapp.com/api/customer/bookingDetail/findByBookingDetailId/";

  static Future<BookingDetail> getAllBookingDetailMoreStepByCustomerId() async{
    try{
      final response = await http.get(GET_BOOKING_DETAIL_MORE_STEP+MyApp.storage.getItem("customerId").toString(),
          headers: {
        "authorization": "Bearer " + MyApp.storage.getItem("token"),
      });
      print(response.statusCode);
      if(response.statusCode == 200){
        final BookingDetail bookingDetail = bookingDetailFromJson(utf8.decode(response.bodyBytes));
        return bookingDetail;
      }else{
        return BookingDetail();
      }
    }catch(e){
      return BookingDetail();
    }
  }
  static Future<BookingDetailResponse> getBookingDetailById(int bookingDetailId) async{
    try{
      final response = await http.get(GET_BOOKING_DETAIL_BY_ID+bookingDetailId.toString(),
          headers: {
        "authorization": "Bearer " + MyApp.storage.getItem("token"),
      });
      print(response.statusCode);
      if(response.statusCode == 200){
        final BookingDetailResponse bookingDetail = bookingDetailResponseFromJson(utf8.decode(response.bodyBytes));
        return bookingDetail;
      }else{
        return BookingDetailResponse();
      }
    }catch(e){
      return BookingDetailResponse();
    }
  }
}