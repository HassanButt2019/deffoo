import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/eco_booking_model.dart';
import 'package:deffo/model/hotel_model.dart';
import 'package:deffo/view/design_course/design_course_app_theme.dart';
import 'package:deffo/view/design_course/home_design_course.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../../Eco_Host/Auth/host_login.dart';

class EcoBookingDetails extends StatefulWidget {
  EcoBookingModel? model;
  String image;
  EcoBookingDetails({this.model, required this.image, required this.type});
  String type;
  @override
  _EcoBookingDetailsState createState() => _EcoBookingDetailsState();
}

class _EcoBookingDetailsState extends State<EcoBookingDetails>
    with TickerProviderStateMixin {
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;
  EcoBookingModel? model;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
    model = widget.model!;
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  // cancelOrderSheet() {
  //   showModalBottomSheet(
  //       enableDrag: false,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  //       isScrollControlled: true,
  //       context: context,
  //       builder: (_) {
  //         return CancelBottomSheet();
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.image))),
                  ),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: DesignCourseAppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: DesignCourseAppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity1,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${model!.title}",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppTheme.purple),
                                            ),
                                            Text("${model!.address}")
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 36,
                                          ),
                                          Text("MAP")
                                        ],
                                      )
                                    ],
                                  ),
                                  Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Card(
                                              elevation: 5,
                                              child: ListTile(
                                                dense: true,
                                                title: Text("Boking Person :"),
                                                subtitle:
                                                    Text("${model!.userName}"),
                                              ),
                                            )),
                                            Expanded(
                                                child: Card(
                                              elevation: 5,
                                              child: ListTile(
                                                dense: true,
                                                title: Text("Check In :"),
                                                subtitle: Text(
                                                    "${model!.checkInDate.toString()}"),
                                              ),
                                            )),
                                            Expanded(
                                                child: Card(
                                              elevation: 5,
                                              child: ListTile(
                                                dense: true,
                                                title: Text("Check out :"),
                                                subtitle: Text(
                                                    "${model!.checkOutDate.toString()}"),
                                              ),
                                            ))
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        elevation: 3,
                                                        child: ListTile(
                                                          dense: true,
                                                          title: Text(
                                                              "No Of Person booked :"),
                                                          trailing: Text(
                                                              "${model!.noOfGuest}"),
                                                        ),
                                                      ),
                                                      Card(
                                                        elevation: 3,
                                                        child: ListTile(
                                                          dense: true,
                                                          title: Text(
                                                              "No Of Rooms booked :"),
                                                          trailing: Text(
                                                              "${model!.noOfRoom}"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Card(
                                                  elevation: 3,
                                                  child: ListTile(
                                                    title: Text("Booking Time"),
                                                    subtitle: Text(
                                                        "${DateFormat.yMEd().format(DateTime.parse(model!.createDate.toString()))}"),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Divider(),
                                  ),
                                  Card(
                                    elevation: 5,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Payment Done",
                                          style:
                                              TextStyle(color: AppTheme.purple),
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text("EcoStay Payment Done"),
                                          trailing:
                                              Text("₹${model!.amount}/Room"),
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text(
                                              "Taxes and services Charges"),
                                          trailing: Text("₹0"),
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text("Coupons"),
                                          trailing: Text("₹0"),
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text("Total amount"),
                                          trailing: Text("₹${model!.amount}"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 500),
                            opacity: opacity3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 16, right: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: widget.type == "Cancelled"
                                        ? InkWell(
                                            onTap: () {
                                              // cancelOrderSheet();
                                            },
                                            child: Container(
                                              height: 48,
                                              decoration: BoxDecoration(
                                                color: AppTheme.purple,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(25.0),
                                                ),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                      color: AppTheme.purple
                                                          .withOpacity(0.5),
                                                      offset: const Offset(
                                                          1.1, 1.1),
                                                      blurRadius: 10.0),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Cancelled',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    letterSpacing: 0.0,
                                                    color: DesignCourseAppTheme
                                                        .nearlyWhite,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : model!.confirmCancel == "1" &&
                                                widget.type != "Completed"
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    size: 16,
                                                    color: Colors.yellow,
                                                  ),
                                                  Text(
                                                    "Confirm",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              )
                                            : !status
                                                ? InkWell(
                                                    onTap: () {
                                                      if (widget.type ==
                                                          "Completed") {
                                                        showBottom();
                                                      } else {
                                                        setState(() {
                                                          status = true;
                                                        });
                                                        cancel("2");
                                                      }

                                                      // cancelOrderSheet();
                                                    },
                                                    child: Container(
                                                      height: 48,
                                                      decoration: BoxDecoration(
                                                        color: AppTheme.purple,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(25.0),
                                                        ),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                              color: AppTheme
                                                                  .purple
                                                                  .withOpacity(
                                                                      0.5),
                                                              offset:
                                                                  const Offset(
                                                                      1.1, 1.1),
                                                              blurRadius: 10.0),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          widget.type ==
                                                                  "Completed"
                                                              ? "Rate Booking"
                                                              : 'Booking Cancel',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                            letterSpacing: 0.0,
                                                            color:
                                                                DesignCourseAppTheme
                                                                    .nearlyWhite,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).padding.bottom,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 30.0 - 35,
              right: 35,
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: CurvedAnimation(
                    parent: animationController!, curve: Curves.fastOutSlowIn),
                child: Card(
                  color: AppTheme.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  elevation: 10.0,
                  child: Container(
                    width: 60,
                    height: 60,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "4.2",
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.favorite,
                            color: AppTheme.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: SizedBox(
                width: AppBar().preferredSize.height,
                height: AppBar().preferredSize.height,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(AppBar().preferredSize.height),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
        key: scaffoldKey,
      ),
    );
  }

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();
  PersistentBottomSheetController? controller;
  double rating = 4.0;
  TextEditingController desCon = new TextEditingController();
  showBottom() async {
    controller = await scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Rate Order",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            RatingBar(
              initialRating: rating,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 36,
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: AppTheme.purple,
                ),
                half: Icon(
                  Icons.star_half_rounded,
                  color: AppTheme.purple,
                ),
                empty: Icon(
                  Icons.star_border_rounded,
                  color: AppTheme.purple,
                ),
              ),
              itemPadding: EdgeInsets.zero,
              onRatingUpdate: (rating1) {
                print(rating1);
                controller!.setState!(() {
                  rating = rating1;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            makeInput(desCon, TextInputType.text, label: "Comment"),
            SizedBox(
              height: 10,
            ),
            !status
                ? InkWell(
                    onTap: () {
                      controller!.setState!(() {
                        status = true;
                      });
                      rateOrder();
                    },
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppTheme.purple,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.purple.withOpacity(0.5),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Rate Order",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 0.0,
                            color: DesignCourseAppTheme.nearlyWhite,
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ),
      );
    });
  }
  rateOrder() async {
    await App.init();
    Map param = {
      "property_id": model!.propertyId,
      "comments": desCon.text,
      "rating": rating.toString(),
      "user_id": model!.userId,
      "type_id": model!.type,
    };
    Map response = await apiBaseHelper.postAPICall(
        Uri.parse(
            "https://alphawizztest.tk/Deffo/api/products/AddhotelReviews"),
        param);
    controller!.setState!(() {
      status = false;
    });
    setSnackbar(response['message'], context);
    if (response['status']) {
      Navigator.pop(context, "yes");
      Navigator.pop(context, "yes");
    }
  }
  bool status = false;
  List<EcoBookingModel> bookList = [];
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  cancel(String val) async {
    await App.init();
    Map param = {
      "booking_id": model!.id,
      "confirm_cancel": val,
      //"user_id": "3",
    };
    Map response = await apiBaseHelper.postAPICall(
        Uri.parse(
            "https://alphawizztest.tk/Deffo/api/Authentication/confirm_cancle_booking"),
        param);
    setState(() {
      status = false;
    });
    setSnackbar(response['meassge'], context);
    if (response['status']) {
      setState(() {
        model!.confirmCancel = val;
      });
      Navigator.pop(context, "yes");
    }
  }

  Widget getTimeBoxUI(String text1, String txt2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: DesignCourseAppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: DesignCourseAppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.nearlyBlue,
                ),
              ),
              Text(
                txt2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  color: DesignCourseAppTheme.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
