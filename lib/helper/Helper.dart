


import 'package:intl/intl.dart';
import 'package:spa_customer/models/AvailableTime.dart';
import 'package:spa_customer/models/CustomerSchedule.dart';
import 'package:spa_customer/models/Package.dart';
import 'package:spa_customer/models/RequestBookingDetail.dart';
import 'package:spa_customer/ui/home_screen/home_screen.dart';

class  MyHelper{

  static CustomerSchedule rearrangeSchedule(CustomerSchedule customerSchedule){
    CustomerSchedule result;
    result = customerSchedule;
    for(int i = 0 ; i < customerSchedule.data.length ; i++) {
      for (int j = 0; j < result.data[i].bookingDetailSteps.length; j++) {
        if (result.data[i].bookingDetailSteps[j].isConsultation != "TRUE") {
          if (result.data[i].bookingDetailSteps[j].treatmentService.spaService
              .type == "ONESTEP" ) {
            result.data[i].bookingDetailSteps.removeAt(j);
          }
        }
      }
    }
    return result;
  }

  static String getUserDateFromString(String date){
    DateFormat formatter = new DateFormat("yyyy-MM-dd");
    DateTime bookedDate = formatter.parse(date);
    return bookedDate.day.toString()+"/"+bookedDate.month.toString()+"/"+bookedDate.year.toString();
  }
  static String getUserDate(DateTime date){
    return date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString();
  }
  static String getMachineDate(DateTime date){
    String day;
    String month;
    if(date.day < 10){
      day = "0"+date.day.toString();
    }else{
      day = date.day.toString();
    }
    if(date.month < 10){
      month = "0"+date.month.toString();
    } else{
      month = date.month.toString();
    }
    return date.year.toString()+ "-" + month +"-"+ day;
  }

  static AvailableTime getAvailableTimeForCart(AvailableTime availableTime, List<RequestBookingDetail> listRequestBookingDetail, PackageInstance package, String requestDate){
    DateFormat formatter = new DateFormat("hh:mm:ss");
    // chạy từng phần tử trong list request
    for(var i = 0 ; i<listRequestBookingDetail.length ; i++){
      //lấy mỗi phần từ trong list request, lặp từng phần tử trong cart
      for(var j =0 ; j<HomeScreen.cart.length ; j ++){
        //Nếu Id của service trong list Request = idService trong cart thì lấy duration từ cart để tính số slot bỏ đi
        //phải check xem packageId trong request có trùng với package id đang chọn giờ hay không, nếu trùng thì sẽ không lọc slot vì cần hiện thời gian để sửa
        //phải check xem ngày trong listRequest có trùng với ngày lấy slot hay không, nếu không trùng thì không lọc
        if(listRequestBookingDetail[i].packageId == HomeScreen.cart[j].id && listRequestBookingDetail[i].packageId != package.id && listRequestBookingDetail[i].dateBooking == requestDate){
          int slotQuantity = (HomeScreen.cart[j].totalTime/15).ceil();
          int preSlotQuantity = (package.totalTime/15).ceil();
          print("Duration of service ${HomeScreen.cart[j].id} = ${HomeScreen.cart[j].totalTime}");
          print("Duration of Preservice ${package.id} = ${package.totalTime}");
          //lấy được số slot cần bỏ: slotQuantity
          //tạo list slot không thể đặt
          List<String> listTimeToRemove = <String>[];
          DateFormat formatter = new DateFormat("hh:mm:ss");
          DateTime bookedTime = formatter.parse(listRequestBookingDetail[i].timeBooking);
          listTimeToRemove.add(listRequestBookingDetail[i].timeBooking);
          for(var i = 0 ; i<slotQuantity-1 ; i++){
            bookedTime = bookedTime.add(Duration(minutes: 15));
            listTimeToRemove.add(bookedTime.toString().substring(11,19));
          }
          bookedTime = formatter.parse(listRequestBookingDetail[i].timeBooking);
          for(var i = 0 ; i<preSlotQuantity-1 ; i++){
            bookedTime = bookedTime.add(Duration(minutes: -15));
            listTimeToRemove.add(bookedTime.toString().substring(11,19));
          }
          print("nhung slot duoc bo di: "+listTimeToRemove.toString());
          for(var i = 0 ; i<listTimeToRemove.length ; i++){
            for(var j = 0 ; j<availableTime.data.length ; j++){
              if(availableTime.data[j] == listTimeToRemove[i]){
                availableTime.data.removeAt(j);
              }
            }
          }

        }
      }
    }
    print(availableTime.toJson());
    return availableTime;
  }

  static List<PackageInstance> getListPackageFromListRequestBooking( List<RequestBookingDetail> listRequestBookingDetail){
    List<PackageInstance> result = [];
    for(var i = 0 ; i<listRequestBookingDetail.length ; i++){
      for(var j = 0 ; j<HomeScreen.cart.length ; j++){
        if(listRequestBookingDetail[i].packageId == HomeScreen.cart[j].id){
          result.add(HomeScreen.cart[j]);
        }
      }
    }
    return result;
  }

  // static bool checkIsPendingInDate(Appointment appointment){
  //   bool isPendingExist = false;
  //   for (int i = 0; i < appointment.listScheduleGoSpaItems.length; i++){
  //     if(appointment.listScheduleGoSpaItems[i].booking.status=="pending"){
  //       isPendingExist = true;
  //     }
  //   }
  //   return isPendingExist;
  // }
  // static bool checkIsAssignedInDate(Appointment appointment){
  //   bool isAssignedExist = false;
  //   for (int i = 0; i < appointment.listScheduleGoSpaItems.length; i++){
  //     if(appointment.listScheduleGoSpaItems[i].booking.status=="assigned"){
  //       isAssignedExist = true;
  //     }
  //   }
  //   return isAssignedExist;
  // }

  static String dayOfWeekToText(int dayOfWeek){
    return dayOfWeek == 1
        ? "MON"
        : dayOfWeek == 2
        ? "TUE"
        : dayOfWeek == 3
        ? "WED"
        : dayOfWeek == 4
        ? "THU"
        : dayOfWeek == 5
        ? "FRI"
        : dayOfWeek == 6
        ? "SAT"
        : "SUN";
  }
}