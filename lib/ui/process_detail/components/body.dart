import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/services/firebase_service.dart';
import 'package:spa_customer/ui/chat/chat_screen.dart';

class Body extends StatefulWidget {
  final Datum processDetail;
  const Body({Key key, this.processDetail}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StatusSection(),
        SizedBox(
          height: 10,
        ),
        CompanySection(
          address: widget.processDetail.spaPackage.spa.street +
              " " +
              widget.processDetail.spaPackage.spa.district +
              " " +
              widget.processDetail.spaPackage.spa.city,
          name: widget.processDetail.spaPackage.spa.name,
        ),
        Divider(
          thickness: 1,
          height: 20,
        ),
        StaffSection(
          name: widget.processDetail.bookingDetailSteps[0].consultant.user.fullname==null?"Chưa có tư vấn viên":widget.processDetail.bookingDetailSteps[0].consultant.user.fullname,
          phone: widget.processDetail.bookingDetailSteps[0].consultant.user.fullname==null?"Chưa có tư vấn viên":widget.processDetail.bookingDetailSteps[0].consultant.user.phone,
          id: widget.processDetail.bookingDetailSteps[0].consultant.user.fullname==null?"Chưa có tư vấn viên":widget.processDetail.bookingDetailSteps[0].consultant.user.id,
        ),
        Divider(
          thickness: 1,
          height: 20,
        ),
        ProcessSection(
          serviceName: widget.processDetail.spaPackage.name,
          serviceId: widget.processDetail.spaPackage.id,
          processDetail: widget.processDetail,
        )
      ],
    );
  }
}

class ProcessSection extends StatefulWidget {
  final String serviceName;
  final int serviceId;
  final Datum processDetail;

  const ProcessSection({
    Key key,
    @required this.serviceName,
    @required this.serviceId,
    @required this.processDetail,
  }) : super(key: key);

  @override
  _ProcessSectionState createState() => _ProcessSectionState();
}

class _ProcessSectionState extends State<ProcessSection> {
  bool _loading;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/process.svg"),
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Thông tin chi tiết liệu trình",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dịch Vụ: " + widget.serviceName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                ...List.generate(
                  widget.processDetail.bookingDetailSteps.length,
                      (index) => ProcessStepSection(
                    status: widget.processDetail.bookingDetailSteps[index].statusBooking,
                    date: widget.processDetail.bookingDetailSteps[index].dateBooking == null
                        ? "Chưa đặt lịch"
                        : MyHelper.getUserDate(widget.processDetail.bookingDetailSteps[index].dateBooking) +
                        " Lúc " +
                        widget.processDetail.bookingDetailSteps[index].startTime.substring(0, 5),
                    stepName: widget.processDetail.bookingDetailSteps[index].treatmentService==null?"Tư Vấn":widget.processDetail.bookingDetailSteps[index].treatmentService.spaService.name,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ProcessStepSection extends StatelessWidget {
  final String date, stepName, status;

  const ProcessStepSection({
    Key key,
    this.date,
    this.stepName,
    this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: status == "FINISH"
                    ? kGreen
                    : status == "PENDING"
                    ? Colors.black
                    : kYellow,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              status == "FINISH"
                  ? "$stepName (Đã hoàn tất)"
                  : status == "PENDING"
                  ? stepName
                  : "$stepName (Đang chờ...)",
              style: TextStyle(
                  color: status == "FINISH"
                      ? kGreen
                      : status == "PENDING"
                      ? Colors.black
                      : kYellow,
                  fontSize: 17
              ),
            ),
          ],
        ),
        Container(
          height: 40,
          child: Row(
            children: [
              VerticalDivider(
                thickness: 1,
                width: 10,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Ngày hẹn : $date"),
            ],
          ),
        ),
      ],
    );
  }
}

class StaffSection extends StatefulWidget {
  final String name, phone;
  final int id;


  const StaffSection({
    Key key,
    @required this.name,
    @required this.phone,
    @required this.id,
  }) : super(key: key);

  @override
  _StaffSectionState createState() => _StaffSectionState();
}

class _StaffSectionState extends State<StaffSection> {

  createChatRoom(){
    List<int> users = [MyApp.storage.getItem("customerId"), widget.id];
    FirebaseMethod firebaseMethod = FirebaseMethod();

    String chatRoomId = "${MyApp.storage.getItem("customerId")}_${widget.id}";

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    firebaseMethod.createChatRoom(chatRoomId, chatRoom );

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => ChatScreen()
    ));
  }

  getChatRoomId(int a, int b) {
    if (a > b) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Thông tin nhân viên",
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.name} - ${widget.phone}"),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            onTap: (){
              createChatRoom();
            },
            child: Icon(
              Icons.chat,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class CompanySection extends StatelessWidget {
  final String name, address;

  const CompanySection({
    Key key,
    @required this.name,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: SvgPicture.asset("assets/icons/company.svg"),
                width: 18,
                height: 18,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Thông tin Spa",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name),
                Text(address),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatusSection extends StatelessWidget {
  const StatusSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(color: kBlue),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                height: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Liệu trình vẫn đang được tiếp tục !",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Text(
                      "Theo dõi liệu trình thường xuyên để không bị lỡ hẹn với spa của bạn",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 15),
              child: Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset("assets/icons/ongoing.svg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
