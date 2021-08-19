import 'package:flutter/material.dart';
import 'package:spa_customer/constant.dart';
import 'package:spa_customer/models/BookingDetail.dart';

class ProcessStepDetailScreen extends StatelessWidget {
  final BookingDetailStep bookingDetailStep;

  const ProcessStepDetailScreen({Key key, this.bookingDetailStep})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: kPrimaryColor,
                width: double.infinity,
                height: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Tên bước dịch vụ: ",
                      style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                    Text(
                      bookingDetailStep.treatmentService.spaService.name,
                      style: TextStyle(fontSize: 27, color: Colors.grey[100]),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MÔ TẢ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.description,
                          color: kTextColor,
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Text(
                                bookingDetailStep.consultationContent
                                    .description == ""
                                    ? "Không có mô tả"
                                    : bookingDetailStep.consultationContent
                                    .description,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: kTextColor,
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child:
                              bookingDetailStep.consultationContent.note == null
                                  ?
                              Text("Chưa có ghi chú",
                                style: TextStyle(fontSize: 16),
                              )
                                  : Text(
                                bookingDetailStep.consultationContent.note == ""
                                    ? "Không có ghi chú"
                                    : bookingDetailStep.consultationContent
                                    .note,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: kTextColor,
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: bookingDetailStep.consultationContent
                                  .expectation == null ?
                              Text("Chưa có kết quả dự kiến",
                                style: TextStyle(fontSize: 16),
                              )
                                  : Text(
                                bookingDetailStep.consultationContent
                                    .expectation == ""
                                    ? "Không có kết quả dự kiến"
                                    : bookingDetailStep.consultationContent
                                    .expectation,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "CHUYÊN VIÊN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    bookingDetailStep.staff != null ?
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage:
                          NetworkImage(bookingDetailStep.staff.user.image),
                          backgroundColor: Colors.transparent,
                        ),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20),
                              child: Text(
                                bookingDetailStep.staff.user.fullname,
                                style: TextStyle(fontSize: 16),
                              ),
                            ))
                      ],
                    )
                        : Text("Chưa có chuyên viên")
                    ,
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "THÔNG TIN CHI TIẾT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [

                        Expanded(
                          flex: 1,
                          child: SizedBox(width: 150, height: 150,
                            child:Image.network(bookingDetailStep.consultationContent.imageBefore == null ?'https://via.placeholder.com/150':bookingDetailStep.consultationContent.imageBefore),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: SizedBox(width: 150, height: 150,
                            child:Image.network(bookingDetailStep.consultationContent.imageAfter == null ?'https://via.placeholder.com/150':bookingDetailStep.consultationContent.imageAfter),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("Trước khi điều trị")),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(child: Text("Sau khi điều trị")),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
