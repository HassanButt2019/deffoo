import 'dart:convert';

import 'package:deffo/Eco_Host/Auth/config.dart';
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
import 'package:http/http.dart' as http;
class SelectCity extends StatefulWidget {


  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  String? search;
  String selectedId="";
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

  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  getCity()async{
    await App.init();
    Map param = {
      "cities":controller.text,
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
    getCity();
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
                          getCity();
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
                      getCity();
                     /* for(int i = 0;i<cityList.length;i++){
                        if(cityList[i].name.toString().toLowerCase().contains(controller.text.toLowerCase().trim())){
                          setState(() {
                            cityList[i].check = true;
                          });
                        }else{
                          setState(() {
                            cityList[i].check = false;
                          });
                        }
                      }*/
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
                  return cityList[index].check?Column(
                    children: [
                      ListTile(
                        title: Text("${cityList[index].name}"),
                        trailing: Icon(selectedId == cityList[index].id?Icons.radio_button_checked:Icons.radio_button_unchecked,color: Colors.black,),
                        onTap: (){
                          setState(() {
                            selectedId = cityList[index].id;
                          });
                          Navigator.pop(context,selectedId+","+cityList[index].name);
                        },
                      ),
                      Divider()
                    ],
                  ):SizedBox();
                },
              ):Center(child: CircularProgressIndicator(),),
            )
          ],
        ),
      ),
    );
  }

}
