import 'dart:convert';
import 'package:deffo/Screen/Payment/hotel_booking.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/amenities_model.dart';
import 'package:deffo/model/rating_model.dart';
import 'package:deffo/view/home_page/ui_view/hotel_slider_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class EcoStayDetailsPage extends StatefulWidget {
  final animationController;
  final hotelDetail;
  final hotelImage;
  String? roomNumber,memberNumber,startDate,endDate;


  EcoStayDetailsPage(
      {this.animationController,
      this.hotelDetail,
      this.hotelImage,
      this.roomNumber,
      this.memberNumber,
      this.startDate,
      this.endDate});

  @override
  _EcoStayDetailsPageState createState() => _EcoStayDetailsPageState();
}

var hotelPrice;
var hotelName;
var hotelId;
String path="";
List<RatingModel> ratingList = [];
bool status = true;
class _EcoStayDetailsPageState extends State<EcoStayDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hotelPrice = "";
    hotelName = "";
    hotelId = "";
    getReview();
  }


  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();


  getReview()async{
    await App.init();
    Map param = {
      "property_id":widget.hotelDetail.propertyId,
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/products/Reviews"), param);
    setState(() {
      status= false;
      ratingList.clear();
    });
    if(response['status']){
      for(var v in response['Products']){
        setState(() {
          path = response['url'];
          ratingList.add(RatingModel.fromJson(v));
        });

      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color(0xff4E1973),
                Color(0xff603181),
                Color(0xff774F95),
              ])),
        ),
      ),
      bottomSheet: Card(
        child: Container(
          height: height * .1,
          width: width,
          child: Row(
            children: [
              SizedBox(
                width: width * .02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text:hotelPrice!=""? '₹$hotelPrice':"Select Type",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: const <TextSpan>[
                        TextSpan(
                            text: '/Day  ',
                            style: TextStyle(fontWeight: FontWeight.w400)),
                       /* TextSpan(
                            text: '₹500',

                            style: TextStyle(fontWeight: FontWeight.w400,decoration: TextDecoration.lineThrough,fontSize: 12)),
                   */   ],
                    ),
                  ),
                  Text(hotelName.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
              Spacer(),
              CustomButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HotelBooking(
                            bookData: widget.hotelDetail,
                            room_id: roomSelect,
                            hotelId: hotelId,
                            hotelName: hotelName,
                            hotelPrice: hotelPrice,
                            startDate: widget.startDate,
                            endDate: widget.endDate,
                            roomNumber: widget.roomNumber,
                            memberNumber: widget.memberNumber,
                            hotelDetail: widget.hotelDetail,
                            hotelImage: widget.hotelImage,
                          )));
                },
                buttonTitle: "Book Now",
              ),
              SizedBox(
                width: width * .02,
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(seconds: 2),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 100.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                widget.hotelImage.data.isEmpty
                    ? Container()
                    : DemoSlider(
                        proImage: widget.hotelImage,
                      ),
                HotelDescription(
                  propertiesDetails: widget.hotelDetail,
                  onResult: (result){
                    setState(() {
                      hotelId = result['id'];
                      hotelName = result['name'];
                      hotelPrice = result['price'];
                    });
                  },
                ),
                Divider(),
                HotelGallery(),
                HotelReview(widget.hotelDetail,
                ),
                SizedBox(
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
String? roomSelect;
class HotelDescription extends StatefulWidget {
  final propertiesDetails;
  ValueChanged onResult;
  HotelDescription({Key? key, this.propertiesDetails,required this.onResult}) : super(key: key);

  @override
  State<HotelDescription> createState() => _HotelDescriptionState();
}

class _HotelDescriptionState extends State<HotelDescription> {
  List groupContain = [];
  var sendInternet = [];
  var sendOthers = [];
  var sendBedRoom = [];
  var sendTv = [];
  var sendRoomHeater = [];
  var sendToilet = [];
  var sendHotWater = [];
  var image = [];

  var selectedPrice;

  Future<AmenitiesModel?> readJson() async {
    final String response =
        await rootBundle.loadString('assets/amenities.json');
    final data = await json.decode(response);
    if (data != null) {
      final str = await data;
      return AmenitiesModel.fromJson(str);
    } else {
      return null;
    }
  }

  convert() {
    List cInternet = [];
    List cOthers = [];
    // List cBedroom = [];
    // List cTv = [];
    // List cRoomHeater = [];
    // List cToilet = [];
    // List cHotDrinking = [];
    if (widget.propertiesDetails.internet.toString() != "" &&
        widget.propertiesDetails.internet.toString() != "[]") {
      cInternet = widget.propertiesDetails.internet
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (widget.propertiesDetails.others.toString() != "" &&
        widget.propertiesDetails.others.toString() != "[]") {
      cOthers = widget.propertiesDetails.others
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }

    List finalList = List.from(cInternet)..addAll(cOthers);

    for (var i = 0; i < finalList.length; i++) {
      groupContain.add(finalList[i].toString().trim());
      print(finalList[i].toString().trim());
    }

    for (var i = 0; i < cInternet.length; i++) {
      sendInternet.add(cInternet[i].toString().trim());
      print(cInternet[i].toString().trim());
    }

    for (var i = 0; i < cOthers.length; i++) {
      sendOthers.add(cOthers[i].toString().trim());
      print(cOthers[i].toString().trim());
    }
    setState(() {});
  }

  getFacility(e, cBedroom, cTv, cRoomHeater, cToilet, cHotDrinking) {
    setState(() {
      sendBedRoom = [];
      sendTv = [];
      sendRoomHeater = [];
      sendToilet = [];
      sendHotWater = [];
    });

    if (e['bedroom'].toString() != "" && e['bedroom'].toString() != "[]") {
      cBedroom = e['bedroom']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (e['tv'].toString() != "" && e['tv'].toString() != "[]") {
      cTv = e['tv']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (e['room_heater'].toString() != "" && e['room_heater'].toString() != "[]") {
      cRoomHeater = e['room_heater']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (e['toilet'].toString() != "" && e['toilet'].toString() != "[]") {
      cToilet = e['toilet']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (e['hot_drinking'].toString() != "" && e['hot_drinking'].toString() != "[]") {
      cHotDrinking = e['hot_drinking']
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    for (var i = 0; i < cBedroom.length; i++) {
      sendBedRoom.add(cBedroom[i].toString().trim());
    }

    for (var i = 0; i < cTv.length; i++) {
      sendTv.add(cTv[i].toString().trim());
    }

    for (var i = 0; i < cRoomHeater.length; i++) {
      sendRoomHeater.add(cRoomHeater[i].toString().trim());
    }

    for (var i = 0; i < cToilet.length; i++) {
      sendToilet.add(cToilet[i].toString().trim());
    }

    for (var i = 0; i < cHotDrinking.length; i++) {
      sendHotWater.add(cHotDrinking[i].toString().trim());
    }

    setState(() {
      selectedPrice = e['rent_room'];
    });
  }
  var snapshot;
  List cBedroom = [];
  List cTv = [];
  List cRoomHeater = [];
  List cToilet = [];
  List cHotDrinking = [];
  // print(data[0].roomTypeName);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    convert();
    getData();



  }
  bool status =false;
  List typeList = [];
  getData(){
    getRoomByPropertyId1(widget.propertiesDetails.propertyId).then((value) {
      setState(() {
        snapshot =value;
        typeList = snapshot['data'].toList();
        if(typeList.length>0){
          roomSelect = typeList[0]['id'];
          hotelId = typeList[0]['id'];
          hotelName = typeList[0]['room_type_name'];
          hotelPrice = typeList[0]['rent_room'];
        }
        status =true;
        print("${roomSelect} ${hotelId} ${hotelName}");
        print("data"+snapshot.toString());
        widget.onResult({"id":hotelId,"name":hotelName,"price":hotelPrice });
      });
      getFacility(typeList[0], cBedroom, cTv,
          cRoomHeater, cToilet, cHotDrinking);
    });
  }



  @override
  Widget build(BuildContext context) {
    print(sendInternet);
    print(sendRoomHeater);
    print(sendHotWater.isEmpty);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Card(
        child: Container(
      child: Column(
        children: [
          status?snapshot!=null?Column(
            children: [
              ListTile(
                title: Text(
                  "Room Type Available",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Wrap(
                children: typeList.map<Widget>((e) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        roomSelect = e['id'];
                        hotelId = e['id'];
                        hotelName = e['room_type_name'];
                        hotelPrice = e['rent_room'];
                        widget.onResult({"id":hotelId,"name":hotelName,"price":hotelPrice });
                      });
                      getFacility(e, cBedroom, cTv,
                          cRoomHeater, cToilet, cHotDrinking);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppTheme.purple),
                            color: roomSelect == e['id']
                                ? AppTheme.purple
                                : AppTheme.white
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text("${e['room_type_name']}", style: TextStyle(
                            color: roomSelect == e['id']
                                ? AppTheme.white
                                : Colors.black),)),

                  );
                })
                    .toList(),
                spacing: 10,
              ),
              Column(
                children: [
                  amenities(sendBedRoom, "Bedroom"),
                  amenities(sendTv, "TV"),
                  amenities(sendRoomHeater, "Room Heater"),
                  amenities(sendToilet, "Washroom"),
                  amenities(sendHotWater, "Hot Water")
                ],
              )
            ],
          ):SizedBox():Center(child: CircularProgressIndicator()),
          SizedBox(height: 10,),
          ListTile(
            leading: Icon(Icons.location_on_outlined),
            title: Text(
              "${widget.propertiesDetails.title}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppTheme.purple),
            ),
            subtitle: Text(
              "${widget.propertiesDetails.address}",
              style: TextStyle(fontSize: 12),
            ),
        /*    trailing: RichText(
              text: TextSpan(
                text: selectedPrice != null
                    ? '₹ $selectedPrice/Day'
                    : "Select Room",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                children: const <TextSpan>[
                  TextSpan(
                      text: '\n5% Discount',
                      style: TextStyle(fontWeight: FontWeight.w400)),
                ],
              ),
            ),*/
          ),
          SizedBox(
            height: height * .01,
          ),
          widget.propertiesDetails.checkIn == "00:00:00"
              ? Container()
              : Column(
                  children: [
                    ListTile(
                      title: Text("Timing Details"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Chip(
                            label: Text(
                                "Check In : ${widget.propertiesDetails.checkIn}")),
                        Chip(
                            label: Text(
                                "Check In : ${widget.propertiesDetails.checkOut}"))
                      ],
                    ),
                  ],
                ),
          widget.propertiesDetails.description == ""
              ? Container()
              : ListTile(
                  title: Text(
                    "About the place",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: AppTheme.purple),
                  ),
                  subtitle: Text(
                    "${widget.propertiesDetails.description}",
                    textAlign: TextAlign.justify,
                  ),
                ),
          groupContain.length == 0
              ? Container()
              : ListTile(
                  title: Text(
                    "Amenities we Offer",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.purple,
                        fontSize: 18),
                  ),
                ),
          //Available
          amenities(sendInternet, "Internet / Mobile Network present"),
          amenities(sendOthers, "Others"),
        ],
      ),
    ));
  }

  Widget amenities(
    type,
    title,
  ) {
    return type.isNotEmpty
        ? ListTile(
            title: Text("$title",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.purple,
                    fontSize: 12)),
            subtitle: Wrap(
              spacing: 5,
              children: type
                  .map<Widget>((e) => Chip(
                        backgroundColor: Colors.purple.shade300,
                        label: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            e,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          )
        : Container();
  }
}

class HotelGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var image = [
      'assets/hotel/hotel_3.png',
      'assets/hotel/hotel_3.png',
      'assets/hotel/hotel_3.png',
      'assets/hotel/hotel_3.png',
    ];
    return Card(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Pic Taken By EcoGuest",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: AppTheme.purple),
              ),
              trailing: Text(
                "View All",
                style: TextStyle(color: AppTheme.purple),
              ),
            ),
            StaggeredGridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 4,
              staggeredTiles: [
                StaggeredTile.extent(2, 250),
                StaggeredTile.extent(2, 150),
                StaggeredTile.extent(2, 250),
                StaggeredTile.extent(2, 150),
              ],
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              padding: const EdgeInsets.all(4),
              children: image
                  .map((e) => Container(
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                fit: BoxFit.cover, image: AssetImage(e))),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

class HotelReview extends StatelessWidget {
  final propertiesDetails;


  HotelReview(this.propertiesDetails);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Customer reviews",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              dense: true,
              title: Row(
                children: [

                  Text("${double.parse(propertiesDetails.rating).toStringAsFixed(2)} Out Of 5"),
                  RatingBarIndicator(
                    rating:double.parse(propertiesDetails.rating) ,
                    itemBuilder: (context, index) => Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
            ),
            !status?ratingList.length>0?ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: ratingList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(path+"/"+ratingList[index].userImage.toString()),
                            ),
                            title: Text(
                              ratingList[index].userName.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: RatingBarIndicator(
                              rating: double.parse(ratingList[index].rating.toString()),
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 15.0,
                              direction: Axis.horizontal,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          Text(
                            ratingList[index].comment.toString(),
                            style:
                                TextStyle(color: AppTheme.grey, fontSize: 12),
                            textAlign: TextAlign.justify,
                          ),
                          Divider()
                        ],
                      ),
                    ),
                  ],
                );
              },
            ):Center(child: Text("No Reviews"),):Center(child: CircularProgressIndicator(),),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final onTap;

  final buttonTitle;

  const CustomButton({Key? key, this.onTap, this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.purple,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                "$buttonTitle",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
