import 'package:deffo/Screen/Eco-Feel%20Page/cycling/show_cycling_details.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/GetCyclingListModel.dart';
import 'package:deffo/utility/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';


class CyclingListPage extends StatefulWidget {
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final cityId;
  const CyclingListPage({Key? key, this.type, this.startDate, this.endDate, this.memberNumber,this.cityId}) : super(key: key);

  @override
  _CyclingListPageState createState() => _CyclingListPageState();
}

class _CyclingListPageState extends State<CyclingListPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Cycling"),),
      body: FutureBuilder(
          future: getCycleList("",city_id: widget.cityId,start_date: DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.startDate)),end_date:DateFormat("yyyy-MM-dd").format(DateTime.parse(widget.endDate)) ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemCount: snapshot.data.data.length,
                itemBuilder: (BuildContext context, int index) {
                  GetCyclingListModel track = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowCyclingDetails(
                          cycle: track.data![index],
                          type: widget.type,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          memberNumber: widget.memberNumber,
                          imagePath:"${track.imagePath}${track.data![index].image}",
                        )));
                      },
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 2,
                              child: track.data![index].image != ""?
                              CustomImage(url:  "${track.imagePath}${track.data![index].image}",):
                              Card(
                                child: Shimmer.fromColors(
                                  highlightColor: Colors.purple,
                                  baseColor: Colors.white,
                                  child: Image.asset(
                                      "assets/introduction_animation/logo.png"
                                      ,scale: 5
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text("${track.data![index].activityName.toString()}"),
                              subtitle: Text("${track.data![index].address}", maxLines: 2,),
                              trailing: Text("${track.data![index].contactNo}"),

                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },);
            } else if (snapshot.hasError) {
              return Icon(Icons.error_outline);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
