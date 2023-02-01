import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/add_cycling_brands.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_home.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_parts/add_festival_days.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class FestivalDays extends StatefulWidget {
  final edit;
  final fesData;

  const FestivalDays({Key? key, this.edit, this.fesData}) : super(key: key);

  @override
  _FestivalDaysState createState() => _FestivalDaysState();
}

class _FestivalDaysState extends State<FestivalDays> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getFestivalDays(widget.fesData.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .82,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Festival Days Details"),
                        ],
                      ),
                      ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("Days ${index+1}"),
                            trailing: Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    var data = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddFestivalDays(
                                  edit: widget.edit,
                                  fesData: widget.fesData,
                                )));
                    if (data == true) {
                      setState(() {});
                    } else {
                      UtilityHlepar.getToast("No Change");
                    }
                  },
                  child: Icon(Icons.add),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
