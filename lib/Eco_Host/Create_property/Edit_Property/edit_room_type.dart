import 'dart:convert';
import 'dart:io';

import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/amenities_model.dart';
import 'package:deffo/model/response/AddRoomModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/eco_host/list_your_properties.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';

class EditRoomTypePage extends StatefulWidget {
  final index;
  final propertiesDetails;
  final imagePath;
  final edit;

  const EditRoomTypePage(
      {Key? key, this.index, this.propertiesDetails, this.imagePath, this.edit})
      : super(key: key);

  @override
  _EditRoomTypePageState createState() => _EditRoomTypePageState();
}

class _EditRoomTypePageState extends State<EditRoomTypePage> {
  String? selectedValue;
  List groupContain = [];
  var columnCount = 3;
  var bedType;
  var tvType;
  var roomType;
  var heaterType;
  var toiletType;
  var internetType;
  var waterType;

  var sendInternet = [];
  var sendOthers = [];
  var sendBedRoom = [];
  var sendTv = [];
  var sendRoomHeater = [];
  var sendToilet = [];
  var sendHotWater = [];

  var countRoom = 1;

  var chargeController = TextEditingController();

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

  var roomNameController = TextEditingController();
  List<XFile>? _images = [];

  getMultiImage() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images!.isNotEmpty && images.length < 4) {
      setState(() {
        _images = images;
      });
    } else {
      UtilityHlepar.getToast("Limit 4 Images");
    }
  }

  checkEdit() {
    print(widget.edit);
    if (widget.edit == true) {
      roomNameController.text = widget.propertiesDetails.roomTypeName;
      countRoom = int.parse(widget.propertiesDetails.noOfRoom);
      chargeController.text = widget.propertiesDetails.rentRoom;

      // List cInternet = [];
      // List cOthers = [];
      List cBedroom = [];
      List cTv = [];
      List cRoomHeater = [];
      List cToilet = [];
      List cHotDrinking = [];

      // if (widget.propertiesDetails.internet.toString() != "" &&
      //     widget.propertiesDetails.internet.toString() != "[]") {
      //   cInternet = widget.propertiesDetails.internet
      //       .toString()
      //       .replaceAll("[", "")
      //       .replaceAll("]", "")
      //       .trim()
      //       .split(",");
      // }
      // if (widget.propertiesDetails.others.toString() != "" &&
      //     widget.propertiesDetails.others.toString() != "[]") {
      //   cOthers = widget.propertiesDetails.others
      //       .toString()
      //       .replaceAll("[", "")
      //       .replaceAll("]", "")
      //       .trim()
      //       .split(",");
      // }
      if (widget.propertiesDetails.bedroom.toString() != "" &&
          widget.propertiesDetails.bedroom.toString() != "[]") {
        cBedroom = widget.propertiesDetails.bedroom
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .trim()
            .split(",");
      }
      if (widget.propertiesDetails.tv.toString() != "" &&
          widget.propertiesDetails.tv.toString() != "[]") {
        cTv = widget.propertiesDetails.tv
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .trim()
            .split(",");
      }
      if (widget.propertiesDetails.roomHeater.toString() != "" &&
          widget.propertiesDetails.roomHeater.toString() != "[]") {
        cRoomHeater = widget.propertiesDetails.roomHeater
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .trim()
            .split(",");
      }
      if (widget.propertiesDetails.toilet.toString() != "" &&
          widget.propertiesDetails.toilet.toString() != "[]") {
        cToilet = widget.propertiesDetails.toilet
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .trim()
            .split(",");
      }
      if (widget.propertiesDetails.hotDrinking.toString() != "" &&
          widget.propertiesDetails.hotDrinking.toString() != "[]") {
        cHotDrinking = widget.propertiesDetails.hotDrinking
            .toString()
            .replaceAll("[", "")
            .replaceAll("]", "")
            .trim()
            .split(",");
      }

      List finalList = List.from(cBedroom)
        ..addAll(cTv)
        ..addAll(cRoomHeater)
        ..addAll(cToilet)
        ..addAll(cHotDrinking);

      for (var i = 0; i < finalList.length; i++) {
        groupContain.add(finalList[i].toString().trim());
        print(finalList[i].toString().trim());
      }

      for (var i = 0; i < cBedroom.length; i++) {
        sendBedRoom.add(cBedroom[i].toString().trim());
        print(cBedroom[i].toString().trim());
      }

      for (var i = 0; i < cTv.length; i++) {
        sendTv.add(cTv[i].toString().trim());
        print(cTv[i].toString().trim());
      }

      for (var i = 0; i < cRoomHeater.length; i++) {
        sendRoomHeater.add(cRoomHeater[i].toString().trim());
        print(cRoomHeater[i].toString().trim());
      }

      for (var i = 0; i < cToilet.length; i++) {
        sendToilet.add(cToilet[i].toString().trim());
        print(cToilet[i].toString().trim());
      }

      for (var i = 0; i < cHotDrinking.length; i++) {
        sendHotWater.add(cHotDrinking[i].toString().trim());
        print(cHotDrinking[i].toString().trim());
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkEdit();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.propertiesDetails);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            Text(
              "Room Type",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.purple),
            ),
            SizedBox(
              height: 10,
            ),
            DeffoTextField(
              controller: roomNameController,
              hint: "Room Name",
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "No. Of Rooms",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.purple),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                FloatingActionButton(
                  mini: true,
                    onPressed: () {
                      if (countRoom > 1) {
                        setState(() {
                          countRoom--;
                        });
                      } else {}
                    },
                    child: Icon(Icons.remove)),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "$countRoom",
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  width: 10,
                ),
                FloatingActionButton(
                    mini: true,
                    onPressed: () {
                      setState(() {
                        countRoom++;
                      });
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Rate Per Room",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppTheme.purple),
            ),
            SizedBox(
              height: 10,
            ),
            DeffoTextField(
              hint: "₹",
              controller: chargeController,
              keyboard: TextInputType.number,
            ),
            SizedBox(
              height: 30,
            ),
            FutureBuilder(
                future: readJson(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var group = snapshot.data.group;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: group.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    group[index].title,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                GridView.count(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  crossAxisCount: 4,
                                  childAspectRatio: 0.75,
                                  children: List.generate(
                                    group[index].contain.length,
                                    (int ind) {
                                      var item = group[index].contain[ind];
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: columnCount,
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                              child: InkWell(
                                            onTap: () {
                                              print(groupContain);
                                              if (index == 0) {
                                                setState(() {
                                                  bedType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                    sendBedRoom.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                    sendBedRoom.add(item);
                                                  }
                                                });
                                                print(bedType);
                                              } else if (index == 1) {
                                                setState(() {
                                                  tvType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                    sendTv.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                    sendTv.add(item);
                                                  }
                                                });
                                                print(tvType);
                                              } else if (index == 2) {
                                                print("room heater");
                                                setState(() {
                                                  roomType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                    sendRoomHeater.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                    sendRoomHeater.add(item);
                                                  }
                                                });
                                                print(roomType);
                                              } else if (index == 3) {
                                                print("toilet");
                                                setState(() {
                                                  heaterType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                    sendToilet.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                    sendToilet.add(item);
                                                  }
                                                });
                                                print(heaterType);
                                              } else if (index == 4) {
                                                print("hot");
                                                setState(() {
                                                  toiletType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                    sendHotWater.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                    sendHotWater.add(item);
                                                  }
                                                });
                                                print(toiletType);
                                              }
                                            },
                                            child: Card(
                                                color:
                                                    groupContain.contains(item)
                                                        ? AppTheme.purple
                                                        : Colors.white,
                                                child: Center(
                                                    child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                        child: Center(
                                                            child: Image.asset(
                                                      group[index].image[ind],
                                                      //fit: BoxFit.fill,
                                                      color: groupContain
                                                              .contains(item)
                                                          ? Colors.white
                                                          : Colors
                                                              .grey.shade400,
                                                    ))),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Container(
                                                      height: 35,
                                                      color: groupContain
                                                              .contains(item)
                                                          ? Color(0xff6C2C9A)
                                                          : Color(0xffF2F2F2),
                                                      child: Center(
                                                        child: Text(
                                                          "${group[index].contain[ind]}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12,
                                                              color: groupContain
                                                                      .contains(
                                                                          item)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))),
                                          )),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            // ListTile(
            //   title: Text(
            //     "Upload Image",
            //     softWrap: true,
            //     textAlign: TextAlign.left,
            //     style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 18,
            //         color: AppTheme.purple),
            //   ),
            //   trailing: FloatingActionButton(
            //     onPressed: () {
            //       getMultiImage();
            //     },
            //     child: Icon(Icons.add),
            //   ),
            // ),
            // _images!.isNotEmpty
            //     ? GridView.count(
            //         shrinkWrap: true,
            //         physics: ClampingScrollPhysics(),
            //         crossAxisCount: 2,
            //         children: _images!
            //             .map<Widget>((e) => Image.file(File(e.path)))
            //             .toList(),
            //       )
            //     : Container(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () async {
                        try {
                          if (roomNameController.text.isNotEmpty &&
                              chargeController.text.isNotEmpty) {
                            var propertyId = widget.edit
                                ? "${widget.propertiesDetails.propertyId}"
                                : "${widget.propertiesDetails.id}";
                            var roomName = "${roomNameController.text}";
                            var noOfRoom = "$countRoom";
                            var charges = "${chargeController.text}";
                            var bedRoom = "$sendBedRoom";
                            var tv = "$sendTv";
                            var roomHeater = "$sendRoomHeater";
                            var toilet = "$sendToilet";
                            var hotWater = "$sendHotWater";
                            var id = widget.edit == true
                                ? widget.propertiesDetails.id
                                : "true";
                            AddRoomModel? model = await addRoom(
                                propertyId,
                                roomName,
                                noOfRoom,
                                charges,
                                bedRoom,
                                tv,
                                roomHeater,
                                toilet,
                                hotWater,
                                id);
                            if (model!.status == true) {
                              UtilityHlepar.getToast(model.meassge);
                              Navigator.pop(context, true);
                            } else {
                              UtilityHlepar.getToast(model.meassge);
                            }
                          } else {
                            UtilityHlepar.getToast("Fill Mandatory Details");
                          }
                        } catch (e) {
                          print(e);
                          UtilityHlepar.getToast(e);
                        }
                      },
                      child: Text("Create")),
                ),
                SizedBox(
                  width: 15,
                ), Expanded(
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
