import 'dart:io';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_home.dart';
import 'package:deffo/Eco_Host/select_city.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateTrackModel.dart';
import 'package:deffo/model/citymodel.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TrackAndTrailsDetails extends StatefulWidget {
  final edit;
  final trackData;

  const TrackAndTrailsDetails({Key? key, this.edit, this.trackData})
      : super(key: key);

  @override
  _TrackAndTrailsDetailsState createState() => _TrackAndTrailsDetailsState();
}

class _TrackAndTrailsDetailsState extends State<TrackAndTrailsDetails> {
  String? latitude;
  String? longitude;
  var titleController = TextEditingController();
  var contactNameController = TextEditingController();
  var noController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var descController = TextEditingController();
  var trackStartController = TextEditingController();
  var trackEndController = TextEditingController();
  var detailController = TextEditingController();
  var inclusionController = TextEditingController();
  var exclusionController = TextEditingController();
  var termsController = TextEditingController();
  var rateController = TextEditingController();
  var cityCon = TextEditingController();
  String cityId = "";
  int noOfDay = 1;
  int noOfNight = 1;
  bool animateLoading = false;
  File? finalImage;
  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
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
      if(widget.trackData!=null){
        setState(() {
          cityId = widget.trackData.cityId;
          if(cityList.indexWhere((element) => element.id==widget.trackData.cityId)!=-1){
            cityCon.text = cityList[cityList.indexWhere((element) => element.id==widget.trackData.cityId)].name;
          }
        });
      }
    }
  }
  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cropImage(image.path);
    } else {
      UtilityHlepar.getToast("Cancel");
    }
  }

  cropImage(image) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        aspectRatioPresets: [
          // CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Deffo',
            toolbarColor: Colors.purple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      setState(() {
        finalImage = croppedFile;
      });
    }
  }
  var id  = "";
  _createTrack() async {
    try {
      var userId = await MyToken.getUserID();
      var activityName = "${titleController.text}";
      var contactName = "${contactNameController.text}";
      var contactNo = "${noController.text}";
      var emailId = "${emailController.text}";
      var address = "${addressController.text}";
      var dayNo = "$noOfDay";
      var nightNo = "$noOfNight";
      var trackStart = "${trackStartController.text}";
      var trackEnd = "${trackEndController.text}";
      var details = "${detailController.text}";
      var inclusion = "${inclusionController.text}";
      var exclusion = "${exclusionController.text}";
      var terms = "${termsController.text}";
      var rate = "${rateController.text}";
      var image;
      if(finalImage!=null){
        image = finalImage!.path;
      }
      CreateTrackModel? model = await createTrack(
          userId,
          activityName,
          contactName,
          contactNo,
          emailId,
          address,
          dayNo,
          nightNo,
          trackStart,
          trackEnd,
          details,
          inclusion,
          exclusion,
          terms,
          rate ,  image,id , widget.edit,cityId,startDate.toString(),endDate.toString());
      if (model!.status == true) {
        UtilityHlepar.getToast("${model.meassge}");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TrackAndTrailsPage(
                      index: 1,
                      edit: widget.edit,
                      trackData: model.data,
                    )));
      }else{
        UtilityHlepar.getToast("${model.meassge}");
      }
    } catch (e) {
      print(e);
    }
  }


  _updateTrack() async {
    try {
      var id = widget.trackData.id;
      var userId = await MyToken.getUserID();
      var contactName = "${contactNameController.text}";
      var contactNo = "${noController.text}";
      var emailId = "${emailController.text}";
      var address = "${addressController.text}";
      var dayNo = "$noOfDay";
      var nightNo = "$noOfNight";
      var trackStart = "${trackStartController.text}";
      var trackEnd = "${trackEndController.text}";
      var details = "${detailController.text}";
      var inclusion = "${inclusionController.text}";
      var exclusion = "${exclusionController.text}";
      var terms = "${termsController.text}";
      var rate = "${rateController.text}";
      CreateTrackModel? model = await updateTrack(
        id,
          userId,
          contactName,
          contactNo,
          emailId,
          address,
          dayNo,
          nightNo,
          trackStart,
          trackEnd,
          details,
          inclusion,
          exclusion,
          terms,
          rate,cityId);
      if (model!.status == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => TrackAndTrailsPage(
                      index: 1,
                      edit: widget.edit,
                      trackData: model.data,
                    )));
      }
    } catch (e) {
      print(e);
    }
  }

  _update(){
    var data = widget.trackData;
    if(data.activityName!=null){
      titleController.text = data.activityName.toString();
    }
    contactNameController.text = data.contactName;
    noController.text = data.contactNo;
    emailController.text = data.emailId;
    addressController.text = data.address;
    noOfDay = int.parse(data.dayNo.toString());
    noOfNight = int.parse(data.nightNo.toString());
    trackStartController.text = data.trackStartPoint;
    trackEndController.text = data.trackEndPoint;
    detailController.text = data.details;
    inclusionController.text = data.inclusion;
    exclusionController.text = data.exclusion;
    termsController.text = data.termCondition;
    rateController.text = data.ratePerPerson;
    id = data.id;
    cityId = data.cityId;
    startDate = DateTime.parse(data.startDate);
    endDate = DateTime.parse(data.endDate);
    cityCon.text = data.name;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  getCity();
    if(widget.edit==true){
      _update();
    }
  }
  DateTime startDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);
  DateTime endDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day).add(Duration(days: 5));
  Future<void> selectDate(BuildContext context,int i) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDate,
        firstDate: startDate,
        lastDate: DateTime(2023));
    if (picked != null) {
      setState(() {
        if(i==1){
          startDate = picked;
          endDate = picked;
        }else{
          endDate = picked;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height / 120),
          child: Text(
            "Details",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.purple),
          ),
        ),
        finalImage == null
            ? FloatingActionButton(
          onPressed: () {
            getImage();
          },
          child: animateLoading
              ? CircularProgressIndicator()
              : Icon(Icons.add),
        )
            : Container(),
        SizedBox(
          height: 15,
        ),
        finalImage != null
            ? Column(
          children: [
            Image.file(File(finalImage!.path)),
            Divider(
              thickness: 3,
              height: 15,
            )
          ],
        )
            : Center(child: Text("Tap to Add Image")),
        SizedBox(
          height: 15,
        ),
        DeffoTextField(
          controller: titleController,
          hint: "Activity Name",
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
                      initialPosition: LatLng(
                          double.parse(latitude??"22.7196"), double.parse(longitude??"75.8577")),
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
            "Duration",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.purple),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width*0.5,
                child: Text("Number of Days of Track and Trails")),
            Row(
              children: [
                FloatingActionButton(
                  mini: true,
                    onPressed: () {
                      if (noOfDay > 1) {
                        setState(() {
                          noOfDay--;
                        });
                      } else {
                        UtilityHlepar.getToast("Limit");
                      }
                    },
                    child: Icon(Icons.remove)),
                SizedBox(width: 5,),
                Text("$noOfDay"),
                SizedBox(width: 5,),
                FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        noOfDay++;
                      });
                    },
                    child: Icon(Icons.add)),
              ],
            ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.5,
                child: Text("Number of Night of Track and Trails")),
            Row(
              children: [
                FloatingActionButton(
                  mini: true,
                    onPressed: () {
                      if (noOfNight > 1) {
                        setState(() {
                          noOfNight--;
                        });
                      } else {
                        UtilityHlepar.getToast("Limit");
                      }
                    },
                    child: Icon(Icons.remove)),
                SizedBox(width: 5,),
                Text("$noOfNight"),
                SizedBox(width: 5,),
                FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        noOfNight++;
                      });
                    },
                    child: Icon(Icons.add)),
              ],
            ),

          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Start Date",
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    selectDate(context, 1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xff0A6780),
                            size: 17,
                          ),
                          SizedBox(width: 8,),
                          Text(
                            DateFormat("dd/MM/yyyy").format(startDate),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "End Date",
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: (){
                    selectDate(context, 2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(color: Colors.white),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Color(0xff0A6780),
                            size: 16,
                          ),
                          SizedBox(width: 8,),
                          Text(
                            DateFormat("dd/MM/yyyy").format(endDate),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        DeffoTextField(
          controller: trackStartController,
          hint: "Track Starting Point",
        ),
        DeffoTextField(
          controller: trackEndController,
          hint: "Track Ending Point",
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              controller: detailController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Inclusions",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              controller: inclusionController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Exclusion",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              controller: exclusionController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Terms and Conditions",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              maxLines: 5,
              controller: termsController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        DeffoTextField(
          controller: rateController,
          keyboard: TextInputType.phone,
          hint: "Rate Per/Person & Per/Trip",
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      if(finalImage==null){
                        setSnackbar("Please Add Image", context);
                        return;
                      }
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
                      if(rateController.text==""){
                        setSnackbar("Please Fill Rate", context);
                        return;
                      }
                      _createTrack();
                    },
                    child: Text("Save"))),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: ElevatedButton(onPressed: () {}, child: Text("Delete"))),
          ],
        )
      ],
    );
  }
}
