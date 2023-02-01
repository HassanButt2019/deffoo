import 'dart:convert';
import 'dart:io';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/Eco_Host/select_city.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreatePropertyModel.dart';
import 'package:deffo/model/SetPropertyImageModel.dart';
import 'package:deffo/model/citymodel.dart';
import 'package:deffo/model/eco_category.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/home_page/models/meals_list_data.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class CreatePropertyPage extends StatefulWidget {
  final propertiesDetails;
  final checkEdit;

  const CreatePropertyPage({Key? key, this.propertiesDetails, this.checkEdit})
      : super(key: key);

  @override
  _CreatePropertyPageState createState() => _CreatePropertyPageState();
}

class _CreatePropertyPageState extends State<CreatePropertyPage> {

  var selected = true;
  var titleController = TextEditingController();
  var contactNameController = TextEditingController();
  var noController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var descController = TextEditingController();
  var cityCon = TextEditingController();
  String cityId = "";
  String? latitude;

  String? longitude;

  TimeOfDay? _checkInTime=TimeOfDay.now();
  TimeOfDay? _checkOutTime=TimeOfDay.now();
  String? checkIn;
  String? checkOut;

  var columnCount = 3;

  String? selectedEcoTypeImage;

  int ecoStay=0;

  String? selectedEcoType;

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
  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
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
      if(widget.propertiesDetails!=null){
        if(catList.indexWhere((element) => element.id==widget.propertiesDetails.type)!=-1){
          setState(() {
            ecoStay = catList.indexWhere((element) => element.id==widget.propertiesDetails.type);
          });
        }
      }
    }
  }
  List<CityModel1> cityList = [];
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
      if(widget.propertiesDetails!=null){
        setState(() {
          cityId = widget.propertiesDetails.city_id;
          if(cityList.indexWhere((element) => element.id==widget.propertiesDetails.city_id)!=-1){
            cityCon.text = cityList[cityList.indexWhere((element) => element.id==widget.propertiesDetails.city_id)].name;
          }
        });
      }
    }
  }
  int? ecoFeel;

  String? selectedFeelType;

  String? selectedFeelTypeImage;

  File? finalImage;

  _create() async {
    if (titleController.text.isNotEmpty &&
        noController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        addressController.text.isNotEmpty) {
      var userId = await MyToken.getUserID();
      var title = titleController.text;
      var number = noController.text;
      var email = emailController.text;
      var address = addressController.text;
      var contactName = contactNameController.text;
      var checkIn = "${_checkInTime!.hour}:${_checkInTime!.minute}";
      var checkout = "${_checkOutTime!.hour}:${_checkOutTime!.minute}";
      var type = catList[ecoStay].id;
      var typeName = catList[ecoStay].title;
      var description = "${descController.text}";
      var id = widget.checkEdit? widget.propertiesDetails.id:null;
      var edit = widget.checkEdit;
      CreatePropertyModel? model = await createProperty(
          userId,
          title,
          number,
          email,
          address,
          type,
          contactName,
          checkIn,
          checkout,
          typeName,
          description , id , edit,cityId);
      if (model!.status == true) {
        UtilityHlepar.getToast("Created");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MainListProperties(
                  index: 1,
                  propertyData: model.data,
                  checkEdit: widget.checkEdit,
                )));
        print(model.data);
      } else {
        UtilityHlepar.getToast("try Again Later");
      }
    } else {
      UtilityHlepar.getToast("Please enter All Details");
    }
  }

  Future<void> getCurrentLoc() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    if (position.longitude.isNaN && position.latitude.isNaN) {
    } else {
      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
        print(latitude);
      });
    }
  }

  setValue() {
    if (widget.propertiesDetails != null && widget.checkEdit) {
      titleController.text = widget.propertiesDetails.title;
      contactNameController.text = widget.propertiesDetails.contactName;
      noController.text = widget.propertiesDetails.contact;
      emailController.text = widget.propertiesDetails.email;
      addressController.text = widget.propertiesDetails.address;
      descController.text = widget.propertiesDetails.description;
      if (widget.propertiesDetails.type == "1") {
        selected = true;
      } else {
        selected = false;
      }
      checkIn = widget.propertiesDetails.checkIn;
      checkOut = widget.propertiesDetails.checkOut;

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity();
    getCategory();
    getCurrentLoc();
    setValue();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Your Property Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DeffoTextField(
              controller: titleController,
              hint: "Your Stay/ Activity Name",
            ),
            DeffoTextField(
              controller: contactNameController,
              hint: "Contact Name",
            ),
            DeffoTextField(
              controller: noController,
              hint: "Contact Number",
              keyboard: TextInputType.phone,
            ),
            DeffoTextField(
              controller: emailController,
              hint: "Email Id",
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              readOnly: true,
              onTap: ()async{
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectCity()));
                if(result!=""){
                  setState(() {
                      cityId = result.toString().split(",")[0];
                      cityCon.text = result.toString().split(",")[1];
                  });
                }
              },
              controller: cityCon,
              decoration: InputDecoration(
                  prefix: Text("     "),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black)),
                  label: Text("Select City")),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 4,
                    controller: addressController,
                    decoration: InputDecoration(
                        prefix: Text("     "),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.black)),
                        label: Text("Address")),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.purple,
                  ),
                  onPressed: () async {
                    PickResult res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlacePicker(
                          apiKey: "AIzaSyBOhH-_4E4BPqgKR21SUOcMwqpzo_Cmt7o",
                          // Put YOUR OWN KEY here.
                          onPlacePicked: (result) {
                            print(result);
                            Navigator.pop(context, result);
                          },
                          initialPosition: LatLng(double.parse(latitude!),
                              double.parse(longitude!)),
                          useCurrentLocation: true,
                        ),
                      ),
                    );
                    if (res.formattedAddress!.isNotEmpty) {
                      setState(() {
                        addressController.text = res.formattedAddress!;
                      });
                    }
                  },
                )
              ],
            ),
            Divider(
              thickness: 5,
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Your Property Type",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width / 70),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                selected ? AppTheme.purple : Colors.white),
                            side: MaterialStateProperty.all(BorderSide()),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25))))),
                        onPressed: () {
                          setState(() {
                            selected = true;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "EcoStay",
                            style: TextStyle(
                                color: selected ? Colors.white : Colors.black),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            catList.length>0?GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: columnCount,
              children: List.generate(
                catList.length,
                    (int index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    columnCount: columnCount,
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              ecoStay = index;
                            });
                          },
                          child: Card(
                              elevation: index ==
                                  ecoStay
                                  ? 5
                                  : 0,
                              color: index ==
                                  ecoStay
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
                                              color: index ==
                                                  ecoStay
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
                        ),
                      ),
                    ),
                  );
                },
              ),
            ):SizedBox(),
            Divider(
              thickness: 5,
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Check In - Check Out Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: TimeOfDay.now(),
                          onChange: (value) {
                            setState(() {
                              _checkInTime = value;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: Text(
                        _checkInTime != null
                            ? "Check - in ${_checkInTime != null ? "${_checkInTime!.hour} : ${_checkInTime!.minute}" : "Time"}"
                            : "Check-In Time : ${checkIn ?? "Tap here to choose"}",
                      ),
                    ),
                  ),
                ),
                // check out
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        showPicker(
                          context: context,
                          value: TimeOfDay.now(),
                          onChange: (value) {
                            setState(() {
                              _checkOutTime = value;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.4))),
                      child: Text(
                        _checkOutTime != null
                            ? "Check - Out ${_checkOutTime != null ? "${_checkOutTime!.hour} : ${_checkOutTime!.minute}" : "Time"}"
                            :"Check-Out Time : ${checkOut ?? "Tap here to choose"}",
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 5,
              height: 25,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Brief Description",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              maxLines: 7,
              controller: descController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric( vertical: 10),
                  prefix: Text("     "),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black)),
                  label: Text("Brief Description")),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          if(titleController.text==""){
                            setSnackbar("Please Fill Title", context);
                            return;
                          }
                          if(contactNameController.text==""){
                            setSnackbar("Please Fill Contact Name", context);
                            return;
                          }
                          if(noController.text==""||noController.text.length!=10){
                            setSnackbar("Please Fill Contact Number", context);
                            return;
                          }
                          if(validateEmail(emailController.text, "", "")!=null){
                            setSnackbar("Please Fill Valid Email", context);
                            return;
                          }
                          if(cityCon.text==""){
                            setSnackbar("Please Fill City", context);
                            return;
                          }
                          if(addressController.text==""){
                            setSnackbar("Please Fill Address", context);
                            return;
                          }
                          if(descController.text==""){
                            setSnackbar("Please Fill Description", context);
                            return;
                          }

                          _create();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Save"),
                          ],
                        )),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Delete"),
                          ],
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
