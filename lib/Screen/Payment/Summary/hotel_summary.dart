import 'dart:io';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Payment/bookingComplete.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/home_page/ui_view/hotel_slider_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

int selectedIndex = 0;

class HotelSummary extends StatefulWidget {
  String checkIn,
      checkOut,
      checkInTime,
      checkOutTime,
      noOfGuest,
      amount,
      payment;
  String? noOfRoom;
  final hotelImage;
  String name,email,phone;
  HotelSummary(this.checkIn, this.checkOut, this.checkInTime, this.checkOutTime,
      this.noOfGuest, this.amount, this.payment, this.hotelImage,this.name,this.phone,this.email,{this.noOfRoom});

  @override
  State<HotelSummary> createState() => _HotelSummaryState();
}

class _HotelSummaryState extends State<HotelSummary> {
  String name = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await App.init();
    if (App.localStorage.getString("name") != null) {
      setState(() {
        name = App.localStorage.getString("name").toString();
      });
    }
  }
  DateTime? currentBackPressTime;
  Future<bool> onWill1()async{
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      setSnackbar("Press back again to exit",context);
      return Future.value(false);
    }
    exit(1);
    return Future.value();
  }
  Future<bool> onWill()async{
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Booking()));
   // setSnackbar("Please Click On Close",context);
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWill,
      child: Scaffold(
        bottomSheet: ListTile(
          title: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "₹ ${int.parse(widget.amount)}",
                  style: TextStyle(fontSize: 15, color: Colors.green),
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "₹ ${widget.amount}",
                  style: TextStyle(
                      fontSize: 12, decoration: TextDecoration.lineThrough),
                ),
              ),*/
            ],
          ),
          subtitle: Text("inclusive of all charges"),
          trailing: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Booking()));
                },
                child: Text(
                  "Close",
                  style: TextStyle(fontSize: 12),
                )),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.green),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Booking()));
             // setSnackbar("Please Click On Close",context);
            },
          ),
          title: Text(
            "Booking Summary",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: ListView(
          physics: ScrollPhysics(),
          // scrollDirection: Axis.vertical,
          children: [
            Card(
              child: Column(
                children: [
                  widget.hotelImage!=""?Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: widget.hotelImage.data.isEmpty
                        ? Container()
                        : DemoSlider(
                            proImage: widget.hotelImage,
                          ),
                  ):SizedBox(),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    leading: Icon(Icons.comment),
                    title: Text(
                      "Any request for supervisor? We'll try  our best to cover it",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  )
                ],
              ),
            ),
            // Card(
            //   child: ListView(
            //     children: [
            //       ListTile(
            //         title: Text(
            //           "Booking Details",
            //           style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold),
            //           // overflow: TextOverflow.ellipsis,
            //         ),
            //
            //       ),
            //       // Container(
            //       //   width: MediaQuery.of(context).size.width*0.2,
            //       //   child: Column(
            //       //     children: [
            //       //
            //       //     ],
            //       //   ),
            //       // ),
            //
            //     ],
            //
            //   ),
            //
            // ),

            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Booking Details",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text(
                      "Booking Name",
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    trailing: Text(
                      UtilityHlepar.convertNA(widget.name.toString()),
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                  widget.noOfRoom!=null?ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Number Of room",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "${widget.noOfRoom}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ):SizedBox(),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Number Of guest",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "${widget.noOfGuest}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  widget.checkIn!=""?ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Check in",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "${DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.checkIn))}",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ):SizedBox(),
                  widget.checkOut!=""?ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Check out",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "${DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.checkOut))}",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ):SizedBox()
                ],
              ),
            ),
            // Card(
            //   child: Column(
            //     children: [
            //       ListTile(
            //         dense: true,
            //         visualDensity: VisualDensity(vertical:-2),
            //           title: Text("Use Promo Code ", style: TextStyle(
            //             fontSize: 14,
            //             color: Colors.black54
            //         ),),
            //
            //           trailing: Text("VIEW OFFERS",style: TextStyle(
            //             fontSize: 14,
            //             color: Colors.green
            //         ),),
            //       ),
            //
            //     ],
            //   ),
            // ),
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Bill Details",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text(
                      "Tariff",
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                    trailing: Text(
                      "₹ ${widget.amount}",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                 /* ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Discount",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "-₹ 10",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text("Tax",
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Text(
                      "18%",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Divider(
                      color: Colors.black54,
                      indent: 1,
                      thickness: 1,
                    ),
                  ),
                  ListTile(
                    dense: true,
                    visualDensity: VisualDensity(vertical: -2),
                    title: Text(
                      "Total",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                    trailing: Text(
                      "₹ ${int.parse(widget.amount)}",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 65,
            )
          ],
        ),
      ),
    );
  }
}
