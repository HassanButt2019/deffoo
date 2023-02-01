import 'package:deffo/Eco_Host/Create_Cycling/cycling_home.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_home.dart';
import 'package:deffo/Eco_Host/Create_property/create_property.dart';
import 'package:deffo/Eco_Host/Create_tour/tour_home.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_home.dart';
import 'package:deffo/Eco_Host/list_of_types.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/GetCyclingListModel.dart';
import 'package:deffo/model/GetFestivalListModel.dart';
import 'package:deffo/model/GetTourListModel.dart';
import 'package:deffo/model/GetTrackModel.dart';
import 'package:deffo/model/PropertyListModel.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class PropertyListPage extends StatefulWidget {
  const PropertyListPage({Key? key}) : super(key: key);

  @override
  _PropertyListPageState createState() => _PropertyListPageState();
}

class _PropertyListPageState extends State<PropertyListPage> {
  var userId;

  getUserId() async {
    userId = await MyToken.getUserID();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text("Property"),
          actions: [
            IconButton(onPressed: (){
              setState(() {
                UtilityHlepar.getToast("Refreshed");
              });
            }, icon: Icon(Icons.refresh))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          key: Key("type"),
          onPressed: () async {
            var data = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ListOfTypePage()));
           /* if (data) {
              setState(() {});
              print("Loaded");
            }*/
          },
          child: Icon(Icons.add),
        ),
        body: userId!=null?FutureBuilder(
            future: Future.wait([
              getPropertyList(userId),
              getTrack(userId),
              getCycleList(userId),
              getFestivalList(userId),
              getTourList(userId)
            ]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Property"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data[0].data.length,
                      itemBuilder: (BuildContext context, int index) {
                        PropertyListModel data = snapshot.data[0];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      onTap: () async {
                                        var data = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MainListProperties(
                                                      checkEdit: true,
                                                      propertyData:
                                                      snapshot.data[0]
                                                          .data[
                                                      index],
                                                    )));
                                        if (data=="yes") {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) => PropertyListPage()));
                                        }
                                      },
                                      title: Text(
                                        "${data.data![index].title}",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      subtitle: Text(
                                          "${data.data![index].contact}\n${data.data![index].email}\n${data.data![index].address}"),
                                      trailing: Text("Tap to Edit"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Track And Trails"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data[1].data.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetTrackModel data = snapshot.data[1];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      onTap: () async {
                                        var data = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TrackAndTrailsPage(
                                                      edit: true,
                                                      trackData:
                                                      snapshot.data[1]
                                                          .data[
                                                      index],
                                                      index: 0,
                                                    )));
                                        if (data=="yes") {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) => PropertyListPage()));
                                        }
                                      },
                                      title: Text(
                                        "${data.data![index].contactName}",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      subtitle: Text(
                                          "${data.data![index].contactNo}\n${data.data![index].emailId}\n${data.data![index].address}"),
                                      trailing: Text("Tap to Edit"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Cycling"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data[2].data.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetCyclingListModel data = snapshot.data[2];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      onTap: () async {
                                        var data = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CyclingHome(
                                                      edit: true,
                                                      cycleData:
                                                      snapshot.data[2]
                                                          .data[
                                                      index],
                                                      index: 0,
                                                    )));
                                        if (data!="") {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) => PropertyListPage()));
                                        }
                                      },
                                      title: Text(
                                        "${data.data![index].contactName}",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      subtitle: Text(
                                          "${data.data![index].contactNo}\n${data.data![index].emailId}\n${data.data![index].address}"),
                                      trailing: Text("Tap to Edit"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Festivals"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data[3].data.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetFestivalListModel data = snapshot.data[3];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      onTap: () async {
                                        var data = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FestivalHome(
                                                      edit: true,
                                                      fesData:
                                                      snapshot.data[3]
                                                          .data[
                                                      index],
                                                      index: 0,
                                                    )));
                                        if (data!="") {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (context) => PropertyListPage()));
                                        }
                                      },
                                      title: Text(
                                        "${data.data![index].contactName}",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      subtitle: Text(
                                          "${data.data![index].contactNo}\n${data.data![index].emailId}\n${data.data![index].address}"),
                                      trailing: Text("Tap to Edit"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tours and Travel"),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: snapshot.data[4].data.length,
                      itemBuilder: (BuildContext context, int index) {
                        GetTourListModel data = snapshot.data[4];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      onTap: () async {
                                        var data = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TourHome(
                                                      edit: true,
                                                      tourData:
                                                      snapshot.data[4]
                                                          .data[
                                                      index],
                                                      index: 0,
                                                    )));
                                        if (data!="") {
                                          Navigator.pop(context);
                                        }
                                      },
                                      title: Text(
                                        "${data.data![index].contactName}",
                                        style: TextStyle(fontSize: 28),
                                      ),
                                      subtitle: Text(
                                          "${data.data![index].contactNo}\n${data.data![index].emailId}\n${data.data![index].address}"),
                                      trailing: Text("Tap to Edit"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // ExpandablePanel(
                    //   header: Card(
                    //       child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text("Track And Trails"),
                    //       ),
                    //     ],
                    //   )),
                    //   collapsed: Text(
                    //     "",
                    //     softWrap: true,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   expanded: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: snapshot.data[1].data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var track = snapshot.data[1];
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 15),
                    //         child: Card(
                    //           elevation: 3,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25)),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: ListTile(
                    //                     onTap: () async {
                    //                       bool data = await Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                               builder: (context) => TrackAndTrailsPage(edit: true, trackData: track.data[index],)));
                    //                       if (data) {
                    //                         setState(() {});
                    //                         print("done");
                    //                       }
                    //                     },
                    //                     title: Text(
                    //                       "${track.data![index].trackStartPoint} - ${track.data![index].trackEndPoint}",
                    //                       style: TextStyle(fontSize: 28),
                    //                     ),
                    //                     subtitle: Text(
                    //                         "${track.data![index].contactNo}\n${track.data![index].emailId}\n${track.data![index].address}"),
                    //                     trailing: Icon(
                    //                         Icons.arrow_forward_ios_rounded),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // ExpandablePanel(
                    //   header: Card(
                    //       child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text("Cycling"),
                    //       ),
                    //     ],
                    //   )),
                    //   collapsed: Text(
                    //     "",
                    //     softWrap: true,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   expanded: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: snapshot.data[2].data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var track = snapshot.data[2];
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 15),
                    //         child: Card(
                    //           elevation: 3,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25)),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: ListTile(
                    //                     onTap: () async {
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context)=> CyclingHome(edit: true , cycleData: track.data[index],)));
                    //                     },
                    //                     title: Text(
                    //                       "${track.data![index].activityName}",
                    //                       style: TextStyle(fontSize: 28),
                    //                     ),
                    //                     subtitle: Text(
                    //                         "${track.data![index].contactNo}\n${track.data![index].emailId}\n${track.data![index].address}"),
                    //                     trailing: Icon(
                    //                         Icons.arrow_forward_ios_rounded),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // ExpandablePanel(
                    //   header: Card(
                    //       child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text("Festival"),
                    //       ),
                    //     ],
                    //   )),
                    //   collapsed: Text(
                    //     "",
                    //     softWrap: true,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   expanded: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: snapshot.data[3].data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var track = snapshot.data[3];
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 15),
                    //         child: Card(
                    //           elevation: 3,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25)),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: ListTile(
                    //                     onTap: () async {
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context)=> FestivalHome(edit: true, fesData: track.data[index],)));
                    //                     },
                    //                     title: Text(
                    //                       "${track.data![index].activityName}",
                    //                       style: TextStyle(fontSize: 28),
                    //                     ),
                    //                     subtitle: Text(
                    //                         "${track.data![index].contactNo}\n${track.data![index].emailId}\n${track.data![index].address}"),
                    //                     trailing: Icon(
                    //                         Icons.arrow_forward_ios_rounded),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    // ExpandablePanel(
                    //   header: Card(
                    //       child: Column(
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text("Tours"),
                    //       ),
                    //     ],
                    //   )),
                    //   collapsed: Text(
                    //     "",
                    //     softWrap: true,
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    //   expanded: ListView.builder(
                    //     shrinkWrap: true,
                    //     physics: ClampingScrollPhysics(),
                    //     itemCount: snapshot.data[4].data.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       var track = snapshot.data[4];
                    //       return Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 10, horizontal: 15),
                    //         child: Card(
                    //           elevation: 3,
                    //           shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(25)),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Expanded(
                    //                   child: ListTile(
                    //                     onTap: () async {
                    //                       Navigator.push(context, MaterialPageRoute(builder: (context)=> TourHome(
                    //                         edit: true,
                    //                         tourData: track.data[index],
                    //                       )));
                    //                     },
                    //                     title: Text(
                    //                       "${track.data![index].activityName}",
                    //                       style: TextStyle(fontSize: 28),
                    //                     ),
                    //                     subtitle: Text(
                    //                         "${track.data![index].contactNo}\n${track.data![index].emailId}\n${track.data![index].address}"),
                    //                     trailing: Icon(
                    //                         Icons.arrow_forward_ios_rounded),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(child: Text("No Data Available"));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }):CircularProgressIndicator());
  }
}
