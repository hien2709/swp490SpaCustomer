// To parse this JSON data, do
//
//     final requestBookingDetail = requestBookingDetailFromJson(jsonString);

import 'dart:convert';

List<RequestBookingDetail> requestBookingDetailFromJson(String str) => List<RequestBookingDetail>.from(json.decode(str).map((x) => RequestBookingDetail.fromJson(x)));

String requestBookingDetailToJson(List<RequestBookingDetail> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestBookingDetail {
  RequestBookingDetail({
    this.packageId,
    this.dateBooking,
    this.timeBooking,
  });

  int packageId;
  String dateBooking;
  String timeBooking;

  factory RequestBookingDetail.fromJson(Map<String, dynamic> json) => RequestBookingDetail(
    packageId: json["packageId"],
    dateBooking: json["dateBooking"],
    timeBooking: json["timeBooking"],
  );

  Map<String, dynamic> toJson() => {
    "packageId": packageId,
    "dateBooking": dateBooking,
    "timeBooking": timeBooking,
  };
}
