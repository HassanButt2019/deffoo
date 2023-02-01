
import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_details/eco_stay_details.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_details/filter.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/ecolist_model.dart';
import 'package:deffo/view/hotel_booking/calendar_popup_view.dart';
import 'package:deffo/view/hotel_booking/hotel_app_theme.dart';
import 'package:deffo/view/hotel_booking/hotel_list_view.dart';
import 'package:deffo/view/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class EcoStayListPage extends StatefulWidget {
  final hotelType;
  String? roomNumber,memberNumber,startDate,endDate,city_id,id;


  EcoStayListPage({this.hotelType, this.roomNumber, this.memberNumber,this.startDate,this.endDate,this.city_id,this.id});

  @override
  _EcoStayListPageState createState() => _EcoStayListPageState();
}

class _EcoStayListPageState extends State<EcoStayListPage>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
    getEco("");
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
  bool status = true;
  List<EcoModel> ecoList = [];
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  getEco(result)async{
    await App.init();
    setState(() {
      status= true;
    });
    Map param = {'type': widget.id, 'type_name': widget.hotelType,'city_id':widget.city_id};

    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/search_property"), param);
    setState(() {
      status= false;
      ecoList.clear();
    });
    if(response['status']){
      for(var v in response['data']){
        String data ="";
        if(result!=""&&result['amen']!=null){
          print("Okay Data");
          data=result['amen'];
          if(data.contains("Internet")&&v['internet']==""||data.contains("Toilet")&&!v['toilet'].toString().contains("Attached")||
          data.contains("Food")&&!v['others'].toString().contains("Fooding")||data.contains("Pet")&&!v['others'].toString().contains("Pet")
          ){
            print("${data.contains("Internet")&&v['internet']==""}${data.contains("Toilet")&&!v['toilet'].toString().contains("Attached")}${data.contains("Food")&&!v['others'].toString().contains("Fooding")}${data.contains("Pet")&&!v['others'].toString().contains("Pet")}");
          }else{
            if(result!=""&&result['rating']!=null){
              if(double.parse(result['rating'].toString())<=double.parse(v['rating'].toString())){
                setState(() {
                  ecoList.add(EcoModel.fromJson(v));
                });
              }
            }else{
              setState(() {
                ecoList.add(EcoModel.fromJson(v));
              });
            }
          }
        }else{
          if(result!=""&&result['rating']!=null){
            if(double.parse(result['rating'].toString())<=double.parse(v['rating'].toString())){
              setState(() {
                ecoList.add(EcoModel.fromJson(v));
              });
            }
          }else{
            setState(() {
              ecoList.add(EcoModel.fromJson(v));
            });
          }

        }

      }
      if(result!=""){
        if(result['price']!=null&&result['price']=="low"){
          setState(() {
            ecoList.sort((a, b) => double.parse(a.rentRoom.toString()).compareTo(double.parse(b.rentRoom.toString())));
          });
        }
        if(result['price']!=null&&result['price']=="high"){
          setState(() {
            ecoList.sort((a, b) => double.parse(b.rentRoom.toString()).compareTo(double.parse(a.rentRoom.toString())));
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final Animation<double> animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController!,
        curve: Interval((1 / 1) * 1, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );

    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    // Swiper(
                    //     viewportFraction: 2,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return HotelListView(
                    //         callback: () {},
                    //         hotelData: hotelList[1],
                    //         animation: animation,
                    //         animationController: animationController!,
                    //       );
                    //     },
                    //     itemCount: 2,
                    //     itemWidth: width,
                    //     itemHeight: height / 2.2,
                    //     layout: SwiperLayout.STACK),
                   Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder: (BuildContext context,
                            bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        // getSearchBarUI(),
                                        // getTimeDateUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body:  !status?ecoList.length>0?Container(
                          color: HotelAppTheme.buildLightTheme()
                              .backgroundColor,
                          child: ListView.builder(
                            itemCount: ecoList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder:
                                (BuildContext context, int index) {
                              final int count = ecoList.length > 10
                                  ? 10
                                  : ecoList.length;
                              final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval(
                                      (1 / count) * index, 1.0,
                                      curve: Curves
                                          .fastOutSlowIn)));
                              animationController?.forward();
                              return FutureBuilder(
                                  future: getPropertyImage(ecoList[index].propertyId),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      var proImage = snapshot.data;
                                      return HotelListView(
                                        callback: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EcoStayDetailsPage(
                                                        hotelDetail: ecoList[index],
                                                        hotelImage: proImage,
                                                        roomNumber: widget.roomNumber,
                                                        memberNumber: widget.memberNumber,
                                                        startDate: widget.startDate,
                                                        endDate: widget.endDate,
                                                      )));
                                        },
                                        animation: animation,
                                        animationController:
                                        animationController!,
                                        proData: ecoList[index],
                                        proImage: proImage,
                                      );
                                    } else if (snapshot.hasError) {
                                      return Icon(Icons.error_outline);
                                    } else {
                                      return  Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                          ),
                                          elevation: 5,
                                          child: Container(width: width, height: height/4, child: Shimmer.fromColors(
                                              highlightColor: Colors.grey,
                                              baseColor: Colors.white,
                                              child: Image.asset("assets/introduction_animation/logo.png" , scale: 5,)),),),
                                      );
                                    }
                                  });
                            },
                          ),
                        ):Center(child: Text("No Data",),)
                            :Center(child: CircularProgressIndicator(),),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, bottom: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      showDemoDialog(context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Choose date',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Rooms',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1 Room - 2 Adults',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: HotelAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () async{
                      // FocusScope.of(context).requestFocus(FocusNode());
                      // Navigator.push<dynamic>(
                      //   context,
                      //   MaterialPageRoute<dynamic>(
                      //       builder: (BuildContext context) => FiltersScreen(),
                      //       fullscreenDialog: true),
                      // );
                     var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EcoStayFilter()));
                     if(result!=null){
                       getEco(result);
                     }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort, color: AppTheme.purple),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            startDate = startData;
            endDate = endData;
          });
        },
        onCancelClick: () {},
      ),
    );
  }

  Widget getAppBarUI() {
    return AppBar(
      backgroundColor: AppTheme.purple,
      title: Text("${widget.hotelType}"),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );

  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
