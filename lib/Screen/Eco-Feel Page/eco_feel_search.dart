import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/cycling/cycling_list.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/festival/festival_list.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/tours/tours_lists.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/track%20and%20trails/track_and_trails_list.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/city_model.dart';
import 'package:deffo/model/citymodel.dart';
import 'package:deffo/view/hotel_booking/calendar_popup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class EcoFeelSearchPage extends StatefulWidget {
  String? title;
  final type;

  EcoFeelSearchPage({this.title, this.type});

  @override
  _EcoFeelSearchPageState createState() => _EcoFeelSearchPageState();
}

class _EcoFeelSearchPageState extends State<EcoFeelSearchPage> {
  String? search;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  TextEditingController roomNumber = TextEditingController(text: "1");
  TextEditingController memberNumber = TextEditingController(text: "2");
  List<CityModel1> cityList = [];
  TextEditingController controller = new TextEditingController();
  Future<List<CityModel>?> readQuiz() async {
    final String response = await rootBundle.loadString('assets/cities.json');
    if (response.isNotEmpty) {
      final data = response;
      print(data);
      return cityModelFromJson(data);
    } else {
      return null;
    }
  }
  List<String> areaListData = <String>[
    'assets/ecofeel/Track and trails.png',
    'assets/ecofeel/Cycling.png',
    'assets/ecofeel/festivals.png',
    'assets/ecofeel/Tour guid.png',
  ];
  List<String> title = <String>[];
  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  getCitySearch()async{
    await App.init();
    Map param = {
      "cities":controller.text!=""?controller.text:"",
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/Authentication/countries_cities"), param);
    setState(() {
      status= false;
      cityList.clear();
    });
    if(response['status']){
      setSnackbar(response['message'], context);
      if(response['status']){
        for(var v in response['data']){
          setState(() {
            cityList.add(new CityModel1(v['id'], v['name'], v['city_code'], v['state_id'],true));
          });
        }
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCitySearch();
    if(widget.title==""){
      title = <String>[
        'Tracks and Trails',
        'Cycling',
        'Festivals',
        'Tour guides',
      ];
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        autofocus: false,
                        controller: controller,
                        onChanged: (val){
                          getCitySearch();
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppTheme.purple,
                                )),
                            hintText: "search",
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(25)),
                                borderSide:
                                BorderSide(color: AppTheme.purple))),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      getCitySearch();
                    },
                    child: CircleAvatar(
                        backgroundColor: AppTheme.purple,
                        child: Icon(
                          Icons.search,
                          color: AppTheme.white,
                        )),
                  ),
                )
              ],
            ),
            Card(child: getTimeDateUI()),
            showInput
                ? Card(
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: memberNumber,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              labelText: "No. Of Adults",
                              counterText: "",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              // border: OutlineInputBorder(
                              //     borderSide: BorderSide(color: Colors.grey)
                              // ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if (memberNumber.text != "") {
                                setState(() {
                                  showInput = false;
                                });
                              } else {
                                setSnackbar("Please Fill All Field", context);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppTheme.purple,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                "Save".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
            title.length>0?Card(
              child: ExpansionTile(
                  children: [  title.length>0?GridView.count(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 3,
                    children: List.generate(
                      title.length,
                          (int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              widget.title = title[index];
                            });
                          },
                          child: Card(
                              elevation: title[index] ==
                                  widget.title
                                  ? 5
                                  : 0,
                              color: title[index] ==
                                  widget.title
                                  ? AppTheme.purple.withOpacity(.9)
                                  : Colors.white,
                              shadowColor: AppTheme.purple,
                              child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Expanded(
                                          child: Center(
                                              child: Image.asset(
                                                areaListData[index],
                                              ))),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        height: 35,
                                        child: Center(
                                          child: Text(
                                            "${title[index]}",
                                            style: TextStyle(
                                              color: title[index] ==
                                                  widget.title
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))),
                        );
                      },
                    ),
                  ):SizedBox(),],
                  title: Text(widget.title.toString(),style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.bold),)),
            ):SizedBox(),
            Row(
              children: [
                SizedBox(
                  width: 19,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Cities",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Expanded(
              child: cityList.length>0?ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: cityList.length,
                itemBuilder: (BuildContext context, int index) {
                  // return cityList[index].name.toString().toLowerCase().contains(search.toString())?
                  return Column(
                    children: [
                      ListTile(
                        title: Text("${cityList[index].name}"),
                        onTap: (){
                          if(!showInput){
                            // setSnackbar("Please Show", context);
                            if (showInput == false) {
                              if (widget.title == "Tracks and Trails") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TrackAndTrailsListPage(
                                              type: widget.title,
                                              startDate:
                                              startDate.toString(),
                                              endDate: endDate.toString(),
                                              memberNumber:
                                              memberNumber.text,
                                              cityId: cityList[index].id,
                                            )));
                              }
                              else if (widget.title == "Cycling") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CyclingListPage(
                                              type: widget.title,
                                              startDate:
                                              startDate.toString(),
                                              endDate: endDate.toString(),
                                              memberNumber:
                                              memberNumber.text,
                                              cityId: cityList[index].id,
                                            )));
                              }
                              else if (widget.title == "Festivals") {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FestivalListPage(
                                              type: widget.title,
                                              startDate:
                                              startDate.toString(),
                                              endDate: endDate.toString(),
                                              memberNumber:
                                              memberNumber.text,
                                              cityId: cityList[index].id,
                                            )));
                              }
                              else if (widget.title == "Tour guides") {
                                print(widget.title);
                                print(startDate.toString());
                                print(endDate.toString());
                                print(memberNumber.text);
                                if (widget.title != null &&
                                    startDate.toString().isNotEmpty &&
                                    endDate.toString().isNotEmpty &&
                                    memberNumber.text.isNotEmpty) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ToursListsPage(
                                                type: widget.title,
                                                startDate:
                                                startDate.toString(),
                                                endDate:
                                                endDate.toString(),
                                                memberNumber:
                                                memberNumber.text,
                                                cityId: cityList[index].id,
                                              )));
                                }
                              }
                            }
                          }

                          else
                            setSnackbar("Please Save Details", context);
                        },
                      ),
                      Divider()
                    ],
                  );
                },
              ):Center(child: CircularProgressIndicator(),),
            )
          /*  Expanded(
              child: FutureBuilder(
                  future: readQuiz(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List city = snapshot.data.map((e) => e.name).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // return snapshot.data[index].name.toString().toLowerCase().contains(search.toString())?
                          return Column(
                            children: [
                              ListTile(
                                title: Text("${snapshot.data[index].name}"),
                                onTap: () {
                                  if (showInput == false) {
                                    if (widget.title == "Tracks and Trails") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrackAndTrailsListPage(
                                                    type: widget.title,
                                                    startDate:
                                                        startDate.toString(),
                                                    endDate: endDate.toString(),
                                                    memberNumber:
                                                        memberNumber.text,
                                                  )));
                                    }
                                    else if (widget.title == "Cycling") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CyclingListPage(
                                                    type: widget.title,
                                                    startDate:
                                                        startDate.toString(),
                                                    endDate: endDate.toString(),
                                                    memberNumber:
                                                        memberNumber.text,
                                                  )));
                                    }
                                    else if (widget.title == "Festivals") {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  FestivalListPage(
                                                    type: widget.title,
                                                    startDate:
                                                        startDate.toString(),
                                                    endDate: endDate.toString(),
                                                    memberNumber:
                                                        memberNumber.text,
                                                  )));
                                    }
                                    else if (widget.title == "Tour guides") {
                                      print(widget.title);
                                      print(startDate.toString());
                                      print(endDate.toString());
                                      print(memberNumber.text);
                                      if (widget.title != null &&
                                          startDate.toString().isNotEmpty &&
                                          endDate.toString().isNotEmpty &&
                                          memberNumber.text.isNotEmpty) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ToursListsPage(
                                                      type: widget.title,
                                                      startDate:
                                                          startDate.toString(),
                                                      endDate:
                                                          endDate.toString(),
                                                      memberNumber:
                                                          memberNumber.text,
                                                    )));
                                      }
                                    }
                                  }
                                },
                              ),
                              Divider()
                            ],
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Icon(Icons.error_outline);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            )*/
          ],
        ),
      ),
    );
  }

  bool showInput = false;

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
                      setState(() {
                        showInput = true;
                      });
                      //FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Number of Adults',
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 16,
                                color: Colors.grey.withOpacity(0.8)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${memberNumber.text} Adults',
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

  void showDemoDialog({BuildContext? context}) {
    showDialog<dynamic>(
      context: context!,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
       // minimumDate: DateTime.now(),
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
}
