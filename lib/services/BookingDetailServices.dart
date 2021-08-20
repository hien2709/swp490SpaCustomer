import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/models/FinishedBookingDetail.dart';

class BookingDetailServices{
  static final String GET_BOOKING_DETAIL_MORE_STEP = "https://swp490spa.herokuapp.com/api/customer/bookingdetail/";
  static final String GET_BOOKING_DETAIL_BY_ID = "https://swp490spa.herokuapp.com/api/customer/bookingDetail/findByBookingDetailId/";
  static final String GET_ALL_FINISH_BOOKING_DETAIL_MORESTEP = "https://swp490spa.herokuapp.com/api/customer/bookingDetailFinishTypeMoreStep/getAll/";
  static final String GET_ALL_FINISH_BOOKING_DETAIL_ONESTEP = "https://swp490spa.herokuapp.com/api/customer/bookingDetailFinishTypeOneStep/getAll/";

  static Future<FinishedBookingDetail> getAllFinishBookingDetailMoreStepByCustomerId() async{
    try{
      final response = await http.get(GET_ALL_FINISH_BOOKING_DETAIL_MORESTEP+MyApp.storage.getItem("customerId").toString(),
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print(response.statusCode);
      if(response.statusCode == 200){
        final FinishedBookingDetail bookingDetail = finishedBookingDetailFromJson(utf8.decode(response.bodyBytes));
        return bookingDetail;
      }else{
        return FinishedBookingDetail();
      }
    }catch(e){
      return FinishedBookingDetail();
    }
  }
  static Future<FinishedBookingDetail> getAllFinishBookingDetailOneStepByCustomerId() async{
    try{
      final response = await http.get(GET_ALL_FINISH_BOOKING_DETAIL_ONESTEP+MyApp.storage.getItem("customerId").toString(),
          headers: {
            "authorization": "Bearer " + MyApp.storage.getItem("token"),
          });
      print(response.statusCode);
      if(response.statusCode == 200){
        final FinishedBookingDetail bookingDetail = finishedBookingDetailFromJson(utf8.decode(response.bodyBytes));
        return bookingDetail;
      }else{
        return FinishedBookingDetail();
      }
    }catch(e){
      return FinishedBookingDetail();
    }
  }
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