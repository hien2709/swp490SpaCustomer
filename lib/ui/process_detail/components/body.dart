import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/helper/Helper.dart';
import 'package:spa_customer/main.dart';
import 'package:spa_customer/models/BookingDetail.dart';
import 'package:spa_customer/services/GeneralServices.dart';
import 'package:spa_customer/ui/chat/components/conversation_screen.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:spa_customer/ui/process_detail/components/process_step_detail.dart';

class Body extends StatefulWidget {
  final Datum processDetail;

  const Body({Key key, this.processDetail}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusSection(),
          SizedBox(
            height: 10,
          ),
          CompanySection(
            address: widget.processDetail.booking.spa.street +
                " " +
                widget.processDetail.booking.spa.district +
                " " +
                widget.processDetail.booking.spa.city,
            name: widget.processDetail.booking.spa.name,
          ),
          Divider(
            thickness: 1,
            height: 20,
          ),
          StaffSection(
            name: widget.processDetail.bookingDetailSteps[0].consultant == null
                ? "Chưa có tư vấn viên"
                : widget.processDetail.bookingDetailSteps[0].consultant.user
                    .fullname,
            phone: widget.processDetail.bookingDetailSteps[0].consultant == null
                ? "Chưa có tư vấn viên"
                : widget
                    .processDetail.bookingDetailSteps[0].consultant.user.phone,
            id: widget.processDetail.bookingDetailSteps[0].consultant == null
                ? null
                : widget.processDetail.bookingDetailSteps[0].consultant.user.id,
            image: widget.processDetail.bookingDetailSteps[0].consultant == null
                ? "https://huyhoanhotel.com/wp-content/uploads/2016/05/765-default-avatar.png"
                : widget
                    .processDetail.bookingDetailSteps[0].consultant.user.image,
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
      ),
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
                    ratingId:
                        widget.processDetail.bookingDetailSteps[index].rating ==
                                null
                            ? null
                            : widget.processDetail.bookingDetailSteps[index]
                                .rating.id,
                    staffId:
                        widget.processDetail.bookingDetailSteps[index].staff ==
                                null
                            ? null
                            : widget.processDetail.bookingDetailSteps[index]
                                .staff.id,
                    status: widget
                        .processDetail.bookingDetailSteps[index].statusBooking,
                    date: widget.processDetail.bookingDetailSteps[index]
                                .dateBooking ==
                            null
                        ? "Chưa đặt lịch"
                        : MyHelper.getUserDate(widget.processDetail
                                .bookingDetailSteps[index].dateBooking) +
                            " Lúc " +
                            widget.processDetail.bookingDetailSteps[index]
                                .startTime
                                .substring(0, 5),
                    stepName: widget.processDetail.bookingDetailSteps[index]
                                .treatmentService ==
                            null
                        ? "Tư Vấn"
                        : widget.processDetail.bookingDetailSteps[index]
                            .treatmentService.spaService.name,
                    bookingDetailStep:
                        widget.processDetail.bookingDetailSteps[index],
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
  final int ratingId, staffId;
  final BookingDetailStep bookingDetailStep;

  const ProcessStepSection({
    Key key,
    this.date,
    this.stepName,
    this.status,
    this.ratingId,
    this.staffId,
    this.bookingDetailStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _borderCorlor;
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              flex: 1,
              child: Container(
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
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 10,
              child: Text(
                status == "FINISH"
                    ? "$stepName(Đã hoàn tất)"
                    : status == "PENDING"
                        ? stepName
                        : "$stepName(Đang chờ...)",
                style: TextStyle(
                    color: status == "FINISH"
                        ? kGreen
                        : status == "PENDING"
                            ? Colors.black
                            : kYellow,
                    fontSize: 18),
              ),
            ),
          ],
        ),
        Container(
          child: Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 5),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ngày hẹn : ",
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        date,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Visibility(
                      visible: status == "FINISH" && stepName != "Tư Vấn",
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (context) {
                                return RatingDialog(
                                    title: "Đánh giá dịch vụ",
                                    image: Icon(
                                      Icons.star_rate,
                                      color: Colors.amberAccent,
                                      size: 100,
                                    ),
                                    message:
                                        "Bạn có hài lòng về dịch vụ không?",
                                    commentHint: "nhận xét của bạn",
                                    submitButton: "Gửi",
                                    onSubmitted: (response) {
                                      print("rating: " +
                                          response.rating.toString());
                                      print("comment: " + response.comment);
                                      GeneralServices.editRating(
                                          staffId,
                                          ratingId,
                                          response.comment,
                                          response.rating.toDouble());
                                    });
                              });
                        },
                        child: Icon(
                          Icons.star_rate,
                          color: kYellow,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Visibility(
                    visible: stepName!="Tư Vấn",
                    child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProcessStepDetailScreen(bookingDetailStep: bookingDetailStep,),
                            ),
                          );
                        },
                        child: Icon(
                      Icons.more_vert,
                      color: kTextColor,
                          size: 28,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StaffSection extends StatefulWidget {
  final String name, phone, image;
  final int id;

  const StaffSection({
    Key key,
    @required this.name,
    @required this.phone,
    @required this.id,
    @required this.image,
  }) : super(key: key);

  @override
  _StaffSectionState createState() => _StaffSectionState();
}

class _StaffSectionState extends State<StaffSection> {
  conversationScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConversationScreen(
                  chatRoomId:
                      "${MyApp.storage.getItem("customerId")}_${widget.id}",
                  consultantPhone: widget.phone,
                  consultantName: widget.name,
                  consultantImage: widget.image,
                )));
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
                    "Tư vấn viên",
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
            onTap: () {
              conversationScreen();
            },
            child: Visibility(
              visible: widget.id != null,
              child: Icon(
                Icons.chat,
                color: kPrimaryColor,
              ),
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
