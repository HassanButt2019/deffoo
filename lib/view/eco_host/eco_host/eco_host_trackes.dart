import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/hotel_model.dart';
import 'package:deffo/model/track_model.dart';

import 'package:deffo/view/design_course/course_info_screen.dart';
import 'package:deffo/view/eco_host/eco_host/eco_feel_mgmt.dart';
import 'package:deffo/view/eco_host/eco_host/show_details.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Eco_Host/Auth/booking_model.dart';

class EcoHostTrack extends StatefulWidget {
  const EcoHostTrack({Key? key}) : super(key: key);

  @override
  _EcoHostTrackState createState() => _EcoHostTrackState();
}

class _EcoHostTrackState extends State<EcoHostTrack> {
  DateTime focused = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
  }
  Map data = {
    "Pending":Colors.orange,
    "Confirmed":Colors.yellow,
    "Cancelled":Colors.red,
    "Completed":Colors.green,
  };
  List<String> statusList = ["Pending","Confirmed","Cancelled","Completed"];
  String selected = "Pending";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: DeffoAppBar(
          title: "EcoFeel Tracks Mgmt",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          /*  Padding(
              padding: const EdgeInsets.all(8.0),
              child: TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: focused,
                currentDay: focused,
                rowHeight: 35,
                onDaySelected: (s, f) {
                  setState(() {
                    focused = s;
                  });
                },
              ),
            ),
            Divider(),*/
            ListTile(
              title: Text("Booking List"),
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: statusList.map((e){
                return       InkWell(
                  onTap: (){
                    setState(() {
                      selected =e;
                    });
                  },
                  child: Chip(
                    backgroundColor: e==selected?AppTheme.purple:AppTheme.grey,
                    label: Text(e,style: TextStyle(fontSize: 12.0,color: Colors.white,),),),
                );
              }).toList(),
            ),
            SizedBox(height: 10,),
            !status?ListView.builder(
              shrinkWrap: true,
              itemCount: bookList.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                String status1 = "Pending";
                if(bookList[index].confirmCancel.toString()=="0"){
                  status1 = "Pending";
                }else if(bookList[index].confirmCancel.toString()=="1"){
                  status1 = "Confirmed";
                }else if(bookList[index].confirmCancel.toString()=="2"){
                  status1 = "Cancelled";
                }
                if(bookList[index].completeBooking.toString()=="1"){
                  status1 = "Completed";
                }
                return status1==selected?InkWell(
                  onTap: () async{
                    var result = await    Navigator.push<dynamic>(
                      context,
                      MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) => EcoFeelDetails("complete_track_and_trails_booking","confirm_cancle_track_and_trails_booking",model:bookList[index],imagePath: imagePath+bookList[index].image.toString(),),
                      ),
                    );
                    if(result=="yes"){
                      setState(() {
                        status = true;
                        bookList.clear();
                      });
                      getBooking();
                    }

                  },
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                            AssetImage("assets/hotel/hotel_2.png"),
                          ),
                          title: Text("${bookList[index].userName}"),
                          subtitle: Text(
                              "Number of persons:${bookList[index].noOfGuest}"),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Total amount"),
                              Text("₹${bookList[index].amount}")
                            ],
                          ),
                        ),
                        ListTile(
                          dense: true,
                          leading: CircleAvatar(
                            backgroundColor: data[status1],
                            radius: 10,
                          ),
                          title: Text("Status : ${status1}"),
                          trailing: Text("Payment\n${bookList[index].payment}",textAlign: TextAlign.end,),
                          subtitle: Text(
                              "Start Point : ${bookList[index].trackStartPoint}\nEnd Point : ${bookList[index].trackEndPoint}"),
                        )
                      ],
                    ),
                  ),
                ):SizedBox();
              },
            ):CircularProgressIndicator()
          ],
        ),
      ),
    );
  }

  bool status = true;
  List<TrackModel> bookList = [];
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  String imagePath = "";
  getBooking() async {
    await App.init();
    Map param = {
      "host_id": App.localStorage.getString("userid"),
     // "host_id": "3",
    };
    Map response = await apiBaseHelper.postAPICall(
        Uri.parse(
            "https://alphawizztest.tk/Deffo/api/Authentication/track_trails_booking_by_host_id"),
        param);
    setState(() {
      status = false;
    });
    setSnackbar(response['meassge'], context);
    if (response['status']) {
      for(var v in response['data']){
        setState(() {
          imagePath = response['image_path'];
          bookList.add(TrackModel.fromJson(v));
        });
      }
    }
  }
}
