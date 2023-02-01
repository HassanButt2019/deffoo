import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/model/hotel_model.dart';

import 'package:deffo/view/design_course/course_info_screen.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host_cycling.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host_festival.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host_tours.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host_trackes.dart';
import 'package:deffo/view/home_page/fitness_app_theme.dart';
import 'package:deffo/view/home_page/ui_view/area_list_view.dart';
import 'package:deffo/view/home_page/ui_view/hotel_slider_image.dart';
import 'package:deffo/view/home_page/ui_view/running_view.dart';
import 'package:deffo/view/home_page/ui_view/title_view.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../Eco_Host/Auth/booking_model.dart';
String feelPath = "";
class EcoFeelMgmt extends StatefulWidget {
  const EcoFeelMgmt({Key? key}) : super(key: key);

  @override
  _EcoFeelMgmtState createState() => _EcoFeelMgmtState();
}

class _EcoFeelMgmtState extends State<EcoFeelMgmt> with TickerProviderStateMixin{
  DateTime focused = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
   // getBooking();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: DeffoAppBar(
          title: "EcoFeel Booking Mgmt",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            getMainListViewUI(),
          ],
        ),
      ),
    );
  }
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/ecofeel/Track and trails.png',
    'assets/ecofeel/Cycling.png',
    'assets/ecofeel/festivals.png',
    'assets/ecofeel/Tour guid.png',
  ];
  List<String> title = <String>[
    'Tracks and Trails',
    'Cycling',
    'Festivals',
    'Tour guides',
  ];
  final ScrollController scrollController = ScrollController();
  Widget getMainListViewUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: 16, right: 16, top: 16, bottom: 16),
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: List<Widget>.generate(
          areaListData.length,
              (int index) {
            final int count = areaListData.length;
            final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController?.forward();
            return Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {
                    print(title);
                    if(title[index] == "Tracks and Trails"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackAndTrailsListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EcoHostTrack(

                      )));
                    }else if(title[index] == "Cycling"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> CyclingListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoHostCycling(

                      )));
                    }else if(title[index] =="Festivals"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> FestivalListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoHostFestival(

                      )));
                    }else if(title[index] == "Tour guides"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> ToursListsPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoHostTours(

                      )));
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Image.asset(areaListData[index]),
                        ),
                      ),
                      Expanded(child: Text(title[index]))
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 24.0,
          crossAxisSpacing: 24.0,
          childAspectRatio: 1.0,
        ),
      ),
    );
  }
  bool status = true;
  List<HotelModel> bookList = [];
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  getBooking() async {
    await App.init();
    Map param = {
       "host_id": App.localStorage.getString("userid"),
      //"host_id": "3",
    };
    Map response = await apiBaseHelper.postAPICall(
        Uri.parse(
            "https://alphawizztest.tk/Deffo/api/Authentication/hotel_booking_by_host_id"),
        param);
    setState(() {
      status = false;
    });
    setSnackbar(response['meassge'], context);
    if (response['status']) {
      for(var json in response['data']){
        setState(() {
          bookList.add(HotelModel(
            json['id'],
            json['host_id'],
            json['user_id'],
            json['hotel_cat'],
            json['hotel_sub_cat'],
            json['hotel_cat_id'],
            json['hotel_sub_cat_id'],
            json['check_in'],
            json['check_out'],
            json['check_in_time'],
            json['check_out_time'],
            json['no_of_guest'],
            json['amount'],
            json['payment'],
            json['status'],
            json['create_date'],
            json['restro_id'],
            json['user_phone'],
            json['firstname'],
            json['lastname'],
            json['user_fullname'],
            json['user_email'],
            json['gender'],
            json['user_bdate'],
            json['user_password'],
            json['user_city'],
            json['address'],
            json['varification_code'],
            json['user_image'],
            json['pincode'],
            json['socity_id'],
            json['house_no'],
            json['mobile_verified'],
            json['user_gcm_code'],
            json['user_ios_token'],
            json['varified_token'],
            json['reg_code'],
            json['wallet'],
            json['rewards'],
            json['created'],
            json['modified'],
            json['otp'],
            json['otp_status'],
            json['social'],
            json['firebaseToken'],
            json['country_code'],
            json['area_code'],
            json['user_type'],
            json['driving_licence_no'],
            json['radius'],
            json['vehicle_type'],
            json['vehicle_no'],
            json['login_status'],
            json['driving_licence_photo'],
            json['is_avaible'],
            json['user_name'],
            json['password'],
            json['created_at'],
          ));
        });
      }
    }
  }
}
