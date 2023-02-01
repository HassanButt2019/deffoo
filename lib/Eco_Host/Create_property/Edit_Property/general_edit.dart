import 'dart:convert';

import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/UpdatePropertyModel.dart';
import 'package:deffo/model/amenities_model.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/eco_host/list_your_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class GeneralEditPage extends StatefulWidget {
  final selected;
  final propertiesDetails;
  final checkEdit;

  const GeneralEditPage(
      {Key? key, this.selected, this.propertiesDetails, this.checkEdit})
      : super(key: key);

  @override
  _GeneralEditPageState createState() => _GeneralEditPageState();
}

class _GeneralEditPageState extends State<GeneralEditPage> {
  var columnCount = 3;
  List groupContain = [];

  // Send Data

  var sendInternet = [];
  var sendOthers = [];

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
    if (widget.propertiesDetails.internet.toString() != "" ||
        widget.propertiesDetails.internet.toString() != "[]") {
      print("hey");
      cInternet = widget.propertiesDetails.internet
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (widget.propertiesDetails.others.toString() != "" ||
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
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.checkEdit?
    convert():print("No Edit");
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        widget.selected
            ? FutureBuilder(
                future: readJson(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      var data = snapshot.data.data;
                      var group = snapshot.data.group;
                      var internet = snapshot.data.internet;
                      return AnimationLimiter(
                        child: Column(
                          children: [
                            // Divider(),
                            // SizedBox(
                            //   height: 15,
                            // ),
                            ListTile(
                              title: Text(
                                "Amenities Present (Click To Select)",
                                softWrap: true,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppTheme.purple),
                              ),
                            ),
                            Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Internet / Mobile Network present",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18),
                                    ),
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    crossAxisCount: columnCount,
                                    children: List.generate(
                                      internet.length,
                                      (int ind) {
                                        var item = internet[ind];
                                        return AnimationConfiguration
                                            .staggeredGrid(
                                          position: ind,
                                          duration:
                                              const Duration(milliseconds: 375),
                                          columnCount: columnCount,
                                          child: ScaleAnimation(
                                            child: FadeInAnimation(
                                                child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  if (groupContain
                                                      .contains(item.title)) {
                                                    groupContain
                                                        .remove(item.title);
                                                    sendInternet
                                                        .remove(item.title);
                                                  } else {
                                                    groupContain
                                                        .add(item.title);
                                                    sendInternet
                                                        .add(item.title);
                                                  }
                                                });
                                              },
                                              child: Card(
                                                  color: groupContain
                                                          .contains(item.title)
                                                      ? AppTheme.purple
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Expanded(
                                                          child: Center(
                                                              child:
                                                                  Image.asset(
                                                        item.image,
                                                        color: groupContain
                                                                .contains(
                                                                    item.title)
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
                                                                .contains(
                                                                    item.title)
                                                            ? Color(0xff6C2C9A)
                                                            : Color(0xffF2F2F2),
                                                        child: Center(
                                                          child: Text(
                                                            "${item.title}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                color: groupContain
                                                                        .contains(item
                                                                            .title)
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                            textAlign: TextAlign
                                                                .center,
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
                                ],
                              ),
                            ),
                            Card(
                              elevation: 4,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      "Others",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  GridView.count(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    crossAxisCount: columnCount,
                                    children: List.generate(
                                      data.length,
                                      (int index) {
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
                                                if (groupContain.contains(
                                                    data[index].title)) {
                                                  setState(() {
                                                    groupContain.remove(
                                                        data[index].title);
                                                    sendOthers.remove(
                                                        data[index].title);
                                                  });
                                                } else {
                                                  setState(() {
                                                    groupContain
                                                        .add(data[index].title);
                                                    sendOthers
                                                        .add(data[index].title);
                                                  });
                                                }
                                              },
                                              child: Card(
                                                  color: groupContain.contains(
                                                          data[index].title)
                                                      ? AppTheme.purple
                                                      : Colors.white,
                                                  child: Center(
                                                      child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Expanded(
                                                          child: Center(
                                                              child:
                                                                  Image.asset(
                                                        data[index].image,
                                                        color: groupContain
                                                                .contains(
                                                                    data[index]
                                                                        .title)
                                                            ? AppTheme.white
                                                            : Colors.grey,
                                                      ))),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        color: groupContain
                                                                .contains(
                                                                    data[index]
                                                                        .title)
                                                            ? Color(0xff6C2C9A)
                                                            : Color(0xffF2F2F2),
                                                        child: Center(
                                                          child: Text(
                                                            "${data[index].title}",
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                              color: groupContain
                                                                      .contains(
                                                                          data[index]
                                                                              .title)
                                                                  ? Color(
                                                                      0xffFFFFFF)
                                                                  : Color(
                                                                      0xff000000),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
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
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Icon(Icons.eighteen_mp);
                  }
                })
            : Container(),
        // selected ? PropertyAccountDetails() : Container(),
        widget.selected ? Container() : EcoFeelForm(),

//         Row(
//           children: [
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.5,
//               child: Text(
//                 "Number of Rooms Present in this type",
//                 softWrap: true,
//               ),
//             ),
//             Spacer(),
//             Container(
//               child: Row(
//                 children: [
//                   Container(
//                     height: 30,
//                     width: 30,
//                     child: InkWell(
//                       onTap: () {
//                         if (noOfRoom != 1) {
//                           setState(() {
//                             noOfRoom = noOfRoom - 1;
//                           });
//                         }
//                       },
//                       child: Text(
//                         "-",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 25.0, color: Colors.white),
//                       ),
//                     ),
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(7.0),
//                       color: Colors.purple,
//                     ),
//                   ),
//                   Text(noOfRoom.toString()),
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         noOfRoom = noOfRoom + 1;
//                       });
//                     },
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       child: Text(
//                         "+",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 25.0, color: Colors.white),
//                       ),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(7.0),
//                         color: Colors.purple,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//         Container(
//           margin: EdgeInsets.symmetric(vertical: 20),
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               border:
//                   Border.all(width: 1.0, color: Colors.grey.withOpacity(0.4))),
//           child: TextFormField(
//             controller: desController,
//             maxLines: 10,
//             decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: '''Number of Rooms Present in this type
// Other Description about the your EcoStay'''),
//           ),
//         ),
        widget.selected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            try {
                              dynamic id = widget.propertiesDetails.id;
                              dynamic internet = sendInternet.toString();
                              dynamic others = sendOthers.toString();
                              UpdatePropertyModel? model =
                              await setPropertiesDetails(
                                  id, internet, others);
                              if (model!.status == true) {
                                UtilityHlepar.getToast("Update Successfully");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainListProperties(
                                              index: 2,
                                              propertyData:
                                              widget.propertiesDetails,
                                              checkEdit: widget.checkEdit,
                                            )));
                              } else {
                                UtilityHlepar.getToast("error");
                              }
                            } catch (e) {
                              UtilityHlepar.getToast("Fill All Details");
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Save"),
                            ],
                          )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Delete"))),



                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
