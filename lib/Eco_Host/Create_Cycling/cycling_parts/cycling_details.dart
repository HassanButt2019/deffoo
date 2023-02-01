import 'dart:io';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_home.dart';
import 'package:deffo/Eco_Host/select_city.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateCycleModel.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CyclingDetails extends StatefulWidget {
  final edit;
  final cycleData;
  const CyclingDetails({Key? key, this.edit, this.cycleData}) : super(key: key);

  @override
  _CyclingDetailsState createState() => _CyclingDetailsState();
}

class _CyclingDetailsState extends State<CyclingDetails> {
  String? latitude;
  String? longitude;
  var titleController = TextEditingController();
  var contactNameController = TextEditingController();
  var noController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var descController = TextEditingController();
  var briefController = TextEditingController();
  var inclusionController = TextEditingController();
  var exclusionController = TextEditingController();
  var termsController = TextEditingController();
  var cityCon = TextEditingController();
  String cityId = "";
  var noOfBikes = 1;
  bool animateLoading = false;
  File? finalImage;
  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cropImage(image.path);
    } else {
      UtilityHlepar.getToast("Cancel");
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
  _createCycle() async {
    try {
      var userId = await MyToken.getUserID();
      var activityName = "${titleController.text}";
      var contactName = "${contactNameController.text}";
      var contactNo = "${noController.text}";
      var emailId = "${emailController.text}";
      var address = "${addressController.text}";
      var noOfBikess = "$noOfBikes";
      var brief = "${briefController.text}";
      var inclusion = "${inclusionController.text}";
      var exclusion = "${exclusionController.text}";
      var terms = "${termsController.text}";
      var image;
      if(finalImage!=null){
         image = finalImage!.path;
      }

      CreateCycleModel? model = await createCycle(
          userId,
          activityName,
          contactName,
          contactNo,
          emailId,
          address,
          noOfBikess,
          brief,
          inclusion,
          exclusion,
          terms, image,id , widget.edit,cityId,startDate.toString(),endDate.toString());
      if (model!.status == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CyclingHome(edit: widget.edit , index: 1, cycleData: model.data,)));
        UtilityHlepar.getToast("${model.meassge}");
      }else{
        UtilityHlepar.getToast("${model.meassge}");
      }
    } catch (e) {
      UtilityHlepar.getToast("Something Went Wrong");
      print(e);
    }
  }


  _update(){
    var data = widget.cycleData;
     titleController.text = data.activityName;
     contactNameController.text = data.contactName;
     noController.text = data.contactNo;
     emailController.text = data.emailId;
     addressController.text = data.address;
     noOfBikes = int.parse(data.noOfBikes);
     briefController.text = data.briefOverview;
     inclusionController.text = data.inclusion;
     exclusionController.text = data.exclusion;
     termsController.text = data.termCondition;
      cityId = data.cityId;
      cityCon.text = data.name;
      if(data.startDate!="0000-00-00"){
        startDate = DateTime.parse(data.startDate);
        endDate = DateTime.parse(data.endDate);
      }
    id = data.id;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.edit?_update():print("non");
  }
  Future<bool> back()async{
    Navigator.pop(context,"yes");
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
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
          children: [
            Text("Brands of Bikes You Offers"),
            SizedBox(width: 5,),
            FloatingActionButton(
              mini: true,
                onPressed: () {
                  if (noOfBikes > 1) {
                    setState(() {
                      noOfBikes--;
                    });
                  } else {
                    UtilityHlepar.getToast("Limit");
                  }
                },
                child: Icon(Icons.remove)),
            SizedBox(width: 5,),
            Text("$noOfBikes"),
            SizedBox(width: 5,),
            FloatingActionButton(
              mini: true,
                onPressed: () {
                  setState(() {
                    noOfBikes++;
                  });
                },
                child: Icon(Icons.add)),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Brief Overview",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              controller: briefController,
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
              controller: termsController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
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
                    _createCycle();

                  },
                  child: Text("Save")),
            ),
            SizedBox(width: 25,),
            Expanded(child: ElevatedButton(onPressed: () {  Navigator.pop(context);}, child: Text("Delete"))),
          ],
        )
      ],
    );
  }
}
