import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_home.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_part/fill_days_details.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class TrackAndTrailsDays extends StatefulWidget {
  final edit;
  final trackData;

  const TrackAndTrailsDays({Key? key, this.edit, this.trackData})
      : super(key: key);

  @override
  _TrackAndTrailsDaysState createState() => _TrackAndTrailsDaysState();
}

class _TrackAndTrailsDaysState extends State<TrackAndTrailsDays> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getTrackDays(widget.trackData.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .82,
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height / 120),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Day wise Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppTheme.purple),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: height / 120),
                        child: Text(
                          "Details Provided for : ${snapshot.data.data.length} Day out of ${widget.trackData.dayNo} Days",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: AppTheme.purple),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FillDaysDetails(dayData: snapshot.data.data[index],)));
                            },
                            title: Text("Days ${index + 1}"),
                            trailing: Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    print(widget.trackData.dayNo);
                    if (int.parse(widget.trackData.dayNo) >
                        snapshot.data.data.length) {
                  var data = await    Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FillDaysDetails(trackData: widget.trackData,)));
                  if(data == true){
                    setState(() {
                    });
                  }else{
                    UtilityHlepar.getToast("No Changes");
                  }
                    } else {
                      UtilityHlepar.getToast(
                          "Limit For ${widget.trackData.dayNo} days");
                    }
                  },
                  child: Icon(Icons.add),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
