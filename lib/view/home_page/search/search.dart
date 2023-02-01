import 'dart:convert';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:deffo/api/api_helper/home_helper.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/city_model.dart';
import 'package:deffo/model/citymodel.dart';
import 'package:deffo/model/eco_category.dart';
import 'package:deffo/model/response/category_response.dart';
import 'package:deffo/view/hotel_booking/calendar_popup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class SearchPage extends StatefulWidget {
  String? id,title;
  String type;
  SearchPage(this.type,{this.id,this.title});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? search;
  List<CityModel1> cityList = [];
  TextEditingController controller = new TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  TextEditingController roomNumber = TextEditingController(text: "1");
  TextEditingController memberNumber = TextEditingController(text: "2");

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

  List<CategoryModel> catList = [];
  getCategory()async{
    await App.init();
    Map param = {

    };
    var res = await http.get(Uri.parse(Apipath.home_category),);

    Map response = jsonDecode(res.body);
    print(response);
    setState(() {
      status= false;
    });
    setSnackbar(response['message'], context);
    if(response['status']){
      for(var v in response['data']){
        setState(() {
          catList.add(new CategoryModel(v['id'], v['title'], v['slug'], v['menuId'], v['parent'], v['leval'], v['description'], response['base_url']+v['image'], v['status']));
        });
      }
      if(widget.id==""){
        setState(() {
          widget.id = catList[0].id;
          widget.title = catList[0].title;
        });
      }
    }
  }

  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  getCity()async{
    await App.init();
    Map param = {
      "cities":"",
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/Authentication/countries_cities"), param);
    print(response);
    setState(() {
      status= false;
    });
    setSnackbar(response['message'], context);
    if(response['status']){
      for(var v in response['data']){
        setState(() {
          cityList.add(new CityModel1(v['id'], v['name'], v['city_code'], v['state_id'],true));
        });
      }
    }
  }
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
    if(widget.id==""){
      getCategory();
    }
    getCitySearch();
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
            catList.length>0?Card(
              child: ExpansionTile(
                children: [  catList.length>0?GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 3,
                  children: List.generate(
                    catList.length,
                        (int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            widget.id = catList[index].id;
                            widget.title = catList[index].title;
                          });
                        },
                        child: Card(
                            elevation: catList[index].id ==
                                widget.id
                                ? 5
                                : 0,
                            color: catList[index].id ==
                                widget.id
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
                                            child: Image.network(
                                              catList[index].image,
                                            ))),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      height: 35,
                                      child: Center(
                                        child: Text(
                                          "${catList[index].title}",
                                          style: TextStyle(
                                            color: catList[index].id ==
                                                widget.id
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
            showInput?Card(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: roomNumber,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        labelText: "No. Of Rooms",
                        counterText: "",
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
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
                    SizedBox(height: 20,),
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
                        contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
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
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: () {
                        if(memberNumber.text!=""&&roomNumber.text!=""){
                          setState(() {
                            showInput = false;
                          });
                        }
                        else{
                          setSnackbar("Please Fill All Field", context);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
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
                          if(widget.title!=null){
                            if(!showInput){
                             // setSnackbar("Please Show", context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EcoStayListPage(
                                            id: widget.id,
                                            hotelType: widget.title,
                                            startDate: startDate.toString(),
                                            endDate: endDate.toString(),
                                            roomNumber: roomNumber.text,
                                            memberNumber: memberNumber.text,
                                            city_id: cityList[index].id,
                                          )));
                            }

                            else
                              setSnackbar("Please Save Details", context);
                          }else{
                            setSnackbar("Please Save", context);
                          }

                        },
                      ),
                      Divider()
                    ],
                  );
                },
              ):Center(child: CircularProgressIndicator(),),
            )
          ],
        ),
      ),
    );
  }
  bool showInput =false;
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
                            '${roomNumber.text} Room - ${memberNumber.text} Adults',
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
}
