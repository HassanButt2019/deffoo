import 'package:deffo/Screen/Payment/track_book_now.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:flutter/material.dart';

class TrackDetailsPage extends StatefulWidget {
  final track;
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final imagePath;
  const TrackDetailsPage({Key? key, this.track, this.type, this.startDate, this.endDate, this.memberNumber,this.imagePath}) : super(key: key);

  @override
  _TrackDetailsPageState createState() => _TrackDetailsPageState();
}

class _TrackDetailsPageState extends State<TrackDetailsPage> {
  List brand = ["Day 1", "Day 2", "Day 3 ", "Day 4"];
  var demo = "";

  var titleFont = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  int? day;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TrackBooking(
                bookData: widget.track,
                type: widget.type,
                startDate: widget.startDate,
                endDate: widget.endDate,
                memberNumber: widget.memberNumber,
              )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text("Book Now")
            ],),
          ),
        ),
        body: FutureBuilder(
            future: getTrackDays(widget.track.id),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: MediaQuery.of(context).size.height * .5,
                      flexibleSpace: FlexibleSpaceBar(
                          title: Text("${widget.track.trackStartPoint.toString()} - ${widget.track.trackEndPoint.toString()}",style: TextStyle(color: AppTheme.purple),),
                          background: Image.network(
                            widget.imagePath,
                            fit: BoxFit.cover,
                          )),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      ListTile(
                        title: Text("${widget.track.activityName}"),
                        subtitle: Text(
                            "${widget.track.contactNo}\n${widget.track.emailId}"),
                        trailing:
                            Text("₹ ${widget.track.ratePerPerson}/person"),
                      ),
                      ListTile(
                          title: Text("Address"),
                          subtitle: Text("${widget.track.address}")),
                      ListTile(
                        title: Text("Details", style: titleFont),
                        subtitle: Text(
                          "${widget.track.details}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      FutureBuilder(
                          future: getTrackDays(widget.track.id),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              List data = snapshot.data.data;
                              return data.isNotEmpty
                                  ? Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "Days",
                                            style: titleFont,
                                          ),
                                        ),
                                        Wrap(
                                          spacing: 5,
                                          children: data
                                              .asMap()
                                              .entries
                                              .map<Widget>((e) => InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      demo = e.value.dayDetail;
                                                      day = e.key + 1;
                                                    });
                                                  },
                                                  child: Chip(
                                                      label: Text(
                                                          "Day ${e.key + 1}"
                                                              .toUpperCase()))))
                                              .toList(),
                                        ),
                                        demo.isNotEmpty
                                            ? ListTile(
                                                title: Text("Day $day Details",
                                                    style: titleFont),
                                                subtitle: Text(
                                                  "$demo",
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Container();
                            } else if (snapshot.hasError) {
                              return Icon(Icons.error_outline);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                      Divider(
                        height: 25,
                      ),
                      ListTile(
                        title: Text(
                          "Brief Overview",
                          style: titleFont,
                        ),
                        subtitle: Text(
                          "${widget.track.details}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Divider(
                        height: 25,
                      ),
                      ListTile(
                        title: Text(
                          "Inclusions",
                          style: titleFont,
                        ),
                        subtitle: Text(
                          "${widget.track.inclusion}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Divider(
                        height: 25,
                      ),
                      ListTile(
                        title: Text(
                          "Exclusions",
                          style: titleFont,
                        ),
                        subtitle: Text(
                          "${widget.track.exclusion}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Divider(
                        height: 25,
                      ),
                      ListTile(
                        title: Text(
                          "Terms And Conditions",
                          style: titleFont,
                        ),
                        subtitle: Text(
                          "${widget.track.termCondition}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ])),
                  ],
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }));
  }
}
