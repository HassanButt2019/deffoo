import 'package:deffo/Screen/Eco-Feel%20Page/track%20and%20trails/track_details.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/GetTrackModel.dart';
import 'package:deffo/utility/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class TrackAndTrailsListPage extends StatefulWidget {
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final cityId;
  const TrackAndTrailsListPage(
      {Key? key, this.type, this.startDate, this.endDate, this.memberNumber,this.cityId})
      : super(key: key);

  @override
  _TrackAndTrailsListPageState createState() => _TrackAndTrailsListPageState();
}

class _TrackAndTrailsListPageState extends State<TrackAndTrailsListPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text("Track and Trails"),
        ),
        body: FutureBuilder(
            future: getTrack("",city_id: widget.cityId,start_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.startDate)),end_date:DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.endDate)) ),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    GetTrackModel track = snapshot.data;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TrackDetailsPage(
                                    track: track.data![index],
                                    type: widget.type,
                                    startDate: widget.startDate,
                                    endDate: widget.endDate,
                                    memberNumber: widget.memberNumber,
                                    imagePath : "${track.path}${track.data![index].image}",
                                  )));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 2,
                                child: track.data![index].image != ""
                                    ? CustomImage(
                                        url:
                                            "${track.path}${track.data![index].image}",
                                      )
                                    : Card(
                                        child: Shimmer.fromColors(
                                          highlightColor: Colors.purple,
                                          baseColor: Colors.white,
                                          child: Image.asset(
                                              "assets/introduction_animation/logo.png",
                                              scale: 5),
                                        ),
                                      ),
                              ),
                              ListTile(

                                title: Text(
                                    "${track.data![index].trackStartPoint.toString()} - ${track.data![index].trackEndPoint.toString()}"),
                                subtitle: Text("${track.data![index].details}"),
                                trailing: Text(
                                    "₹ ${track.data![index].ratePerPerson}/person"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
