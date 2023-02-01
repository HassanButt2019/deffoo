import 'package:deffo/Eco_Host/Auth/booking_model.dart';
import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/main.dart';
import 'package:deffo/model/eco_booking_model.dart';
import 'package:deffo/model/track_model.dart';
import 'package:deffo/view/design_course/category_list_view.dart';
import 'package:deffo/view/design_course/course_info_screen.dart';
import 'package:deffo/view/design_course/popular_course_list_view.dart';
import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';
String imagePath = "";
class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CategoryType categoryType = CategoryType.ui;

  bool status = true;

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  List<EcoBookingModel> bookList = [];
  List<EcoBookingModel> cancelList = [];
  List<EcoBookingModel> completeList = [];
  List<TrackModel> bookFeelList = [];
  List<TrackModel> cancelFeelList = [];
  List<TrackModel> completeFeelList = [];
  List<String>  title = <String>[
  'Tracks and Trails',
  'Cycling',
  'Festivals',
  'Tour guides',
  ];
  getBooking()async{
    await App.init();
    Map param = {
      "user_id": App.localStorage.getString("userid"),
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/hotel_booking_by_uesr_id"), param);
    setState(() {
      status= false;
    });
    if(response['status']){
      for(var v in response['data']){
        setState(() {
         // imagePath = response['path'];
          if(v['complte_booking']=="1"){
            completeList.add(EcoBookingModel.fromJson(v));
          }else if(v['confirm_cancel']=="2"){
            cancelList.add(EcoBookingModel.fromJson(v));
          }else{
            bookList.add(EcoBookingModel.fromJson(v));
          }

        });

      }
    }
  }
  String url = "track_trails_booking_by_uesr_id";
  getFeelBooking(url)async{
    await App.init();
    Map param = {
      "user_id": App.localStorage.getString("userid"),
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/$url"), param);
    setState(() {
      status= false;
    });
    if(response['status']){
      for(var v in response['data']){
        setState(() {
          imagePath = response['image_path'];
          if(v['complte_booking']=="1"){
            completeFeelList.add(TrackModel.fromJson(v));
          }else if(v['confirm_cancel']=="2"){
            cancelFeelList.add(TrackModel.fromJson(v));
          }else{
            bookFeelList.add(TrackModel.fromJson(v));
          }
        });

      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBooking();
    getFeelBooking(url);
  }
  bool isFeel = false;
  String selected = "Tracks and Trails";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBarUI(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
                  const SizedBox(
                    width: 16,
                  ),
                  getButtonUI(
                      CategoryType.coding, categoryType == CategoryType.coding),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            categoryType == CategoryType.ui?Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  getCategoryUI(),
                  getPopularCourseUI(),
                  getCancelUI(),
                ],
              ),
            ):Container(
              child: Column(
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: title.map((e){
                      return       InkWell(
                        onTap: (){
                          setState(() {
                            selected =e;
                          });
                          if(selected =="Tracks and Trails"){
                            url = "track_trails_booking_by_uesr_id";
                          }else if(selected =="Cycling"){
                            url = "cycle_booking_by_uesr_id";
                          }else if(selected =="Festivals"){
                            url = "festival_booking_by_uesr_id";
                          }else {
                            url = "tour_booking_by_uesr_id";
                          }
                          setState(() {
                            status = true;
                            bookFeelList.clear();
                            cancelFeelList.clear();
                            completeFeelList.clear();
                          });
                          getFeelBooking(url);
                        },
                        child: Chip(
                          backgroundColor: e==selected?AppTheme.purple:AppTheme.grey,
                          label: Text(e,style: TextStyle(fontSize: 12.0,color: Colors.white,),),),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        getCategoryUI1(),
                        getPopularCourseUI1(),
                        getCancelUI1(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Completed Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        !status?CategoryListView(
          "stay",
          callBack: () {
            moveTo();
          },
          bookingList: completeList.toList(),
        ):Center(child: CircularProgressIndicator(),),
      ],
    );
  }
  Widget getCategoryUI1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Completed Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        !status?CategoryListView(
          "feel",
          callBack: () {
            moveTo();
          },
          bookingList: completeFeelList.toList(),
        ):Center(child: CircularProgressIndicator(),),
      ],
    );
  }
  Widget getCancelUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Cancelled Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        !status?CategoryListView(
          "stay",
          callBack: () {
            moveTo();
          },
          bookingList: cancelList.toList(),
        ):Center(child: CircularProgressIndicator(),),
      ],
    );
  }
  Widget getCancelUI1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            'Cancelled Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        !status?CategoryListView(
          "feel",
          callBack: () {
            moveTo();
          },
          bookingList: cancelFeelList.toList(),
        ):Center(child: CircularProgressIndicator(),),
      ],
    );
  }
  Widget getPopularCourseUI() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Upcoming Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          !status?PopularCourseListView(
            "stay",
            callBack: () {
              moveTo();
            },
            bookingList: bookList.toList(),
          ):Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }
  Widget getPopularCourseUI1() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Upcoming Booking',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          !status?PopularCourseListView(
            "feel",
            callBack: () {
              moveTo();
            },
            bookingList: bookFeelList.toList(),
          ):Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }
  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => BookingDetails(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Eco-Stay';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Eco-Feel';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Basic UI';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color:
                isSelected ? AppTheme.purple : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.purple)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlack,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: DesignCourseAppTheme.nearlyBlue,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Search for course',
                            border: InputBorder.none,
                            helperStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: HexColor('#B9BABC'),
                            ),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: HexColor('#B9BABC'),
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: Icon(Icons.search, color: HexColor('#B9BABC')),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  AppBar getAppBarUI() {
    return AppBar(
      title: Text(
        "My Booking",
        style: TextStyle(color: AppTheme.purple),
      ),
      iconTheme: IconThemeData(color: AppTheme.purple),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
