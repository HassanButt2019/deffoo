import 'dart:io';

import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/DeleteImageModel.dart';
import 'package:deffo/model/SetPropertyImageModel.dart';
import 'package:deffo/utility/custom_widget.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class PropertyImages extends StatefulWidget {
  final propertyId;
  final checkEdit;

  const PropertyImages({Key? key, required this.propertyId, this.checkEdit})
      : super(key: key);

  @override
  _PropertyImagesState createState() => _PropertyImagesState();
}

class _PropertyImagesState extends State<PropertyImages> {
  var loading = [1, 2, 3, 4];



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
  bool save = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return widget.propertyId != null
        ? FutureBuilder(
            future: getPropertyImage(widget.propertyId.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print(widget.propertyId.id);
              if (snapshot.hasData) {
                var data = snapshot.data.data;
                if(data.length>0){
                  save = true;
                }
                var url = snapshot.data.path;
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                        radius: 15,
                                        child: IconButton(
                                            onPressed: () async {
                                              try {
                                                UtilityHlepar.getToast(
                                                    "Please wait while we upload");
                                                SetPropertyImageModel? model =
                                                    await setPropertyImage(
                                                        widget.propertyId.id,
                                                        finalImage!.path
                                                            .toString());
                                                if (model!.status == true) {
                                                  setState(() {
                                                    save = true;
                                                  });
                                                  finalImage = null;
                                                  UtilityHlepar.getToast(
                                                      model.meassge.toString());
                                                  setState(() {});
                                                } else {
                                                  UtilityHlepar.getToast(
                                                      model.meassge.toString());
                                                  setState(() {});
                                                }
                                              } catch (e) {
                                                UtilityHlepar.getToast(
                                                    e.toString());
                                                setState(() {});
                                              }
                                            },
                                            icon: Icon(
                                              Icons.save,
                                              size: 15,
                                            ))),
                                    CircleAvatar(
                                        radius: 15,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                finalImage = null;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 15,
                                            ))),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 3,
                                height: 15,
                              )
                            ],
                          )
                        : Center(child: Text("Tap to Add Image")),
                    GridView.count(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: data
                            .map<Widget>((i) => InkWell(
                                  onLongPress: () async {
                                    try {
                                      UtilityHlepar.getToast("Deleting Image");
                                      DeleteImageModel? model =
                                          await deleteImage(i.id.toString());
                                      if (model!.status == true) {
                                        UtilityHlepar.getToast(
                                            model.meassge.toString());
                                        setState(() {});
                                      } else {
                                        UtilityHlepar.getToast(
                                            model.meassge.toString());
                                      }
                                    } catch (e) {
                                      UtilityHlepar.getToast(e.toString());
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomImage(
                                      url: "$url/${i.propertyImage}",
                                    ),
                                  ),
                                ))
                            .toList(),
                        crossAxisCount: 4),
                    ElevatedButton(
                        onPressed: () {

                          if(!save&&finalImage==null){
                            setSnackbar("Please Add Image", context);
                            return;
                          }
                          if(!save){
                            setSnackbar("Please Save Image", context);
                            return;
                          }
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainListProperties(
                                    propertyData: widget.propertyId,
                                        checkEdit: widget.checkEdit,
                                          index: 3,
                                      )));
                        },
                        child: Text("Next"))
                  ],
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Container(
                  height: height,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    crossAxisCount: 4,
                    children: loading
                        .map<Widget>((e) => Card(
                              child: Shimmer.fromColors(
                                  highlightColor: Colors.grey,
                                  baseColor: Colors.grey,
                                  child: Image.asset(
                                    "assets/introduction_animation/logo.png",
                                    scale: 5,
                                  )),
                            ))
                        .toList(),
                  ),
                );
              }
            })
        : Container();
  }
}
