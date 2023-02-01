import 'dart:io';

import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateTrackDayModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class FillDaysDetails extends StatefulWidget {
  final trackData;
  final  dayData;
  const FillDaysDetails({Key? key, this.trackData, this.dayData}) : super(key: key);

  @override
  _FillDaysDetailsState createState() => _FillDaysDetailsState();
}

class _FillDaysDetailsState extends State<FillDaysDetails> {
  File? finalImage;

  var desController = TextEditingController();


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
  _createTrackDays() async {
    try {
      var trackId = "${widget.trackData.id}";
      var des = "${desController.text}";
      var image = "${finalImage!.path}";
      CreateTrackDayModel? model = await createTrackDays(trackId, des, image);
      if(model!.status == true){
        Navigator.pop(context , true);
        UtilityHlepar.getToast(model.meassge);
      }else{
        UtilityHlepar.getToast(model.meassge);
      }
    } catch (e) {
      print(UtilityHlepar.getToast("Something went Wrong"));
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.dayData!=null){
      desController.text = widget.dayData.dayDetail;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Day Wise Details",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: height / 120),
                  child: Text(
                    "Day Details",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppTheme.purple),
                  ),
                ),
                TextField(
                  controller: desController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            finalImage==null?
            ListTile(
              title: Text("Upload Image"),
              trailing: InkWell(
                onTap: (){
                  getImage();
                },
                child: CircleAvatar(
                  child: Icon(Icons.add),
                ),
              ),
            ):Image.file(File(finalImage!.path)),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _createTrackDays();
                        },
                        child: Text("Save"))),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Delete"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
