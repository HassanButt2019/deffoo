import 'dart:convert';
import 'dart:io';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/edit_property_image.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/PropertyListModel.dart';
import 'package:deffo/model/UpdatePropertyModel.dart';
import 'package:deffo/model/amenities_model.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/home_page/models/meals_list_data.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListYourPropertyPage extends StatefulWidget {
  const ListYourPropertyPage({Key? key}) : super(key: key);

  @override
  _ListYourPropertyPageState createState() => _ListYourPropertyPageState();
}

class _ListYourPropertyPageState extends State<ListYourPropertyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: DeffoAppBar(
          title: "List Your Properties",
          action: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Column(
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(seconds: 1),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                // PropertyImages(),
                Divider(),
                PropertyDetails(),
                // Text("data"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PropertyDetails extends StatefulWidget {
  final propertiesDetails;

  const PropertyDetails({Key? key, this.propertiesDetails}) : super(key: key);
  static ValueNotifier<int> countVal = ValueNotifier(1);

  @override
  State<PropertyDetails> createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  final GlobalKey<ExpansionTileCardState> ecoStayType = new GlobalKey();
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  var selected = true;

  var columnCount = 3;

  List<String> areaListData = <String>[
    'assets/ecofeel/Track and trails.png',
    'assets/ecofeel/Cycling.png',
    'assets/ecofeel/festivals.png',
    'assets/ecofeel/Tour guid.png',
    'assets/ecofeel/Eco Parks.png',
  ];
  List<String> title = <String>[
    'Tracks and Trails',
    'Cycling',
    'Festivals',
    'Tour guides',
    'Eco parks.',
  ];

  int? ecoFeel = 10;
  int? ecoStay = 99;

  String? selectedEcoType;
  String selectedEcoTypeImage = "";

  String? selectedFeelType;
  String selectedFeelTypeImage = "";
  var titleController = TextEditingController();
  var noController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = "${widget.propertiesDetails.title}";
    noController.text = "${widget.propertiesDetails.contact}";
    emailController.text = "${widget.propertiesDetails.email}";
    addressController.text = "${widget.propertiesDetails.address}";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width / 80),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: height / 120),
                child: Text(
                  "Your Property Name",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: AppTheme.purple),
                ),
              ),
              DeffoTextField(
                controller: titleController,
                hint: "Your Stay/ Activity Name",
              ),
              DeffoTextField(
                controller: noController,
                hint: "Contact Number",
              ),
              DeffoTextField(
                controller: emailController,
                hint: "Email Id",
              ),
              TextField(
                controller: addressController,
                maxLines: 7,
                decoration: InputDecoration(
                    prefix: Text("     "),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.black)),
                    label: Text("Address")),
              ),
            ],
          ),
          // InkWell(
          //     onTap: () {
          //       textingSteper.activeStep.value = 3;
          //     },
          //     // onTap: () => Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => PropertyAccountDetails())),
          //     child: button(width)),
          // PropertyAccountDetails(),

// old staps
        ],
      ),
    );
  }
}

//Eco Stay Data
class AmenitiesPage extends StatefulWidget {
  @override
  _AmenitiesPageState createState() => _AmenitiesPageState();
}

class _AmenitiesPageState extends State<AmenitiesPage> {
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

  var columnCount = 3;
  List selected = [];
  var selectIndex = 0;
  var selectedItem = {};

  List groupContain = [];

  var bedType;
  var tvType;
  var roomType;
  var heaterType;
  var toiletType;
  var internetType;
  var waterType;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                        "Amenities Present\n(Click To Select)",
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
                                  fontWeight: FontWeight.w600, fontSize: 18),
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
                                return AnimationConfiguration.staggeredGrid(
                                  position: ind,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: columnCount,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (groupContain
                                              .contains(item.title)) {
                                            groupContain.remove(item.title);
                                          } else {
                                            groupContain.add(item.title);
                                          }
                                        });
                                      },
                                      child: Card(
                                          color:
                                              groupContain.contains(item.title)
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
                                                      child: Image.asset(
                                                item.image,
                                                color: groupContain
                                                        .contains(item.title)
                                                    ? Colors.white
                                                    : Colors.grey.shade400,
                                              ))),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: 35,
                                                color: groupContain
                                                        .contains(item.title)
                                                    ? Color(0xff6C2C9A)
                                                    : Color(0xffF2F2F2),
                                                child: Center(
                                                  child: Text(
                                                    "${item.title}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14,
                                                        color: groupContain
                                                                .contains(
                                                                    item.title)
                                                            ? Colors.white
                                                            : Colors.black),
                                                    textAlign: TextAlign.center,
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            crossAxisCount: columnCount,
                            children: List.generate(
                              data.length,
                              (int index) {
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: columnCount,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                        child: InkWell(
                                      onTap: () {
                                        if (selected
                                            .contains(data[index].title)) {
                                          setState(() {
                                            selected.remove(data[index].title);
                                          });
                                        } else {
                                          setState(() {
                                            selected.add(data[index].title);
                                          });
                                        }
                                        print(selected);
                                      },
                                      child: Card(
                                          color: selected
                                                  .contains(data[index].title)
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
                                                      child: Image.asset(
                                                data[index].image,
                                                color: selected.contains(
                                                        data[index].title)
                                                    ? AppTheme.white
                                                    : Colors.grey,
                                              ))),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Container(
                                                height: 35,
                                                color: selected.contains(
                                                        data[index].title)
                                                    ? Color(0xff6C2C9A)
                                                    : Color(0xffF2F2F2),
                                                child: Center(
                                                  child: Text(
                                                    "${data[index].title}",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: selected.contains(
                                                              data[index].title)
                                                          ? Color(0xffFFFFFF)
                                                          : Color(0xff000000),
                                                    ),
                                                    textAlign: TextAlign.center,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: group.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Card(
                            elevation: 4,
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
                                  crossAxisCount: columnCount,
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
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(bedType);
                                              } else if (index == 1) {
                                                setState(() {
                                                  tvType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(tvType);
                                              } else if (index == 2) {
                                                setState(() {
                                                  roomType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(roomType);
                                              } else if (index == 3) {
                                                setState(() {
                                                  heaterType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(heaterType);
                                              } else if (index == 4) {
                                                setState(() {
                                                  toiletType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(toiletType);
                                              } else if (index == 5) {
                                                setState(() {
                                                  waterType = item;
                                                  if (groupContain
                                                      .contains(item)) {
                                                    groupContain.remove(item);
                                                  } else {
                                                    groupContain.add(item);
                                                  }
                                                });
                                                print(waterType);
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
                                                      height: 15,
                                                    ),
                                                    Expanded(
                                                        child: Center(
                                                            child: Image.asset(
                                                      group[index].image[ind],
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
                                                              fontSize: 14,
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
        });
  }
}



//Eco Feel Data

class EcoFeelForm extends StatefulWidget {
  final form;

  const EcoFeelForm({Key? key, this.form}) : super(key: key);

  @override
  _EcoFeelFormState createState() => _EcoFeelFormState();
}

class _EcoFeelFormState extends State<EcoFeelForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          widget.form != null && widget.form == 0 || widget.form == 1
              ? Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ExpansionTileCard(
                      expandedTextColor: AppTheme.purple,
                      expandedColor: Colors.grey.shade200,
                      leading: Icon(
                        Icons.track_changes,
                        size: 40,
                        color: AppTheme.purple,
                      ),
                      title: Text("Tracks and Trails"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              DeffoTextField(
                                hint: "Available From",
                              ),
                              DeffoTextField(
                                hint: "Available From",
                              ),
                              DeffoTextField(
                                hint: "Starting location",
                              ),
                              DeffoTextField(
                                hint: "End location",
                              ),
                              DeffoTextField(
                                hint: "Rate per Day/Per person",
                              ),
                              DeffoTextField(
                                hint: "Brief description",
                              ),
                              DeffoTextField(
                                hint: "Per hour/ per day/per person",
                              ),
                              DeffoTextField(
                                hint: "Brief description",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ],
                )
              : Container(),
          widget.form != null && widget.form == 2
              ? Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ExpansionTileCard(
                      expandedTextColor: AppTheme.purple,
                      expandedColor: Colors.grey.shade200,
                      leading: Icon(
                        Icons.festival,
                        size: 40,
                        color: AppTheme.purple,
                      ),
                      title: Text("Festivals"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              DeffoTextField(
                                hint: "Available From",
                              ),
                              DeffoTextField(
                                hint: "Available To",
                              ),
                              DeffoTextField(
                                hint: "Rate Per person",
                              ),
                              DeffoTextField(
                                hint: "Brief description",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ],
                )
              : Container(),
          widget.form != null && widget.form == 3 || widget.form == 4
              ? Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    ExpansionTileCard(
                      expandedTextColor: AppTheme.purple,
                      expandedColor: Colors.grey.shade200,
                      leading: Icon(
                        Icons.tour,
                        size: 40,
                        color: AppTheme.purple,
                      ),
                      title: Text("Tour guides"),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              DeffoTextField(
                                hint: "Available From",
                              ),
                              DeffoTextField(
                                hint: "Available To",
                              ),
                              DeffoTextField(
                                hint: "Rate Per person",
                              ),
                              DeffoTextField(
                                hint: "Brief description",
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLines: 14,
              decoration: InputDecoration(
                  prefix: Text("     "),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.black)),
                  label: Text("Brief Description")),
            ),
          ),
        ],
      ),
    );
  }
}

class SelectYourType extends StatefulWidget {
  final propertiesDetails;
  final index;

  const SelectYourType({Key? key, this.propertiesDetails, this.index})
      : super(key: key);

  @override
  State<SelectYourType> createState() => _SelectYourTypeState();
}

class _SelectYourTypeState extends State<SelectYourType> {
  final GlobalKey<ExpansionTileCardState> ecoStayType = new GlobalKey();
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  var selected = true;

  var columnCount = 3;

  List<String> areaListData = <String>[
    'assets/ecofeel/Track and trails.png',
    'assets/ecofeel/Cycling.png',
    'assets/ecofeel/festivals.png',
    'assets/ecofeel/Tour guid.png',
    'assets/ecofeel/Eco Parks.png',
  ];
  List<String> title = <String>[
    'Tracks and Trails',
    'Cycling',
    'Festivals',
    'Tour guides',
    'Eco parks.',
  ];

  int? ecoFeel = 10;
  int? ecoStay = 99;

  String? selectedEcoType;
  String selectedEcoTypeImage = "";

  String? selectedFeelType;
  String selectedFeelTypeImage = "";

  var desController = TextEditingController();

  TimeOfDay? _checkInTime;

  TimeOfDay? _checkOutTime;

  var noOfRoom = 1;

  check() async {
    if (widget.propertiesDetails.type == "1") {
      setState(() {
        selected = true;
      });
    } else {
      setState(() {
        selected = false;
      });
    }
  }

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

  List selectedData = [];
  var selectIndex = 0;
  var selectedItem = {};

  List groupContain = [];

  var bedType;
  var tvType;
  var roomType;
  var heaterType;
  var toiletType;
  var internetType;
  var waterType;

  // Send Data

  var sendInternet = [];
  var sendOthers = [];
  var sendBedRoom = [];
  var sendTv = [];
  var sendRoomHeater = [];
  var sendToilet = [];
  var sendHotWater = [];

  convert() {
    //type Name
    if (widget.propertiesDetails.typeName != "") {
      selectedEcoType = widget.propertiesDetails.typeName;
      noOfRoom = widget.propertiesDetails.noOfRoom != "0"
          ? int.parse(widget.propertiesDetails.noOfRoom)
          : 1;
      print(widget.propertiesDetails.noOfRoom);
    }

    if (widget.propertiesDetails.noOfRoom != "") {
      noOfRoom = int.parse(widget.propertiesDetails.noOfRoom);
    }
    desController.text = widget.propertiesDetails.description;

    List cInternet = [];
    List cOthers = [];
    List cBedroom = [];
    List cTv = [];
    List cRoomHeater = [];
    List cToilet = [];
    List cHotDrinking = [];

    if (widget.propertiesDetails.internet.toString() != "" &&
        widget.propertiesDetails.internet.toString() != "[]") {
      cInternet = widget.propertiesDetails.internet
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
    if (widget.propertiesDetails.others.toString() != "" &&
        widget.propertiesDetails.others.toString() != "[]") {
      cOthers = widget.propertiesDetails.others
          .toString()
          .replaceAll("[", "")
          .replaceAll("]", "")
          .trim()
          .split(",");
    }
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

    List finalList = List.from(cInternet)
      ..addAll(cOthers)
      ..addAll(cBedroom)
      ..addAll(cTv)
      ..addAll(cRoomHeater)
      ..addAll(cToilet)
      ..addAll(cHotDrinking);

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.propertiesDetails != null) {
      check();
      convert();
    }
  }

  @override
  Widget build(BuildContext context) {
    // convert();
    var width = MediaQuery.of(context).size.width;
    return Container();
  }
}
