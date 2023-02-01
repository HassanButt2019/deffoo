import 'package:deffo/Eco_Host/Create_Cycling/cycling_home.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/add_cycling_brands.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/GetCycleBrandsModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class BikeBrandsList extends StatefulWidget {
  final edit;
  final cycleData;
  const BikeBrandsList({Key? key, this.edit, this.cycleData}) : super(key: key);

  @override
  _BikeBrandsListState createState() => _BikeBrandsListState();
}

class _BikeBrandsListState extends State<BikeBrandsList> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return FutureBuilder(
        future: getCycleBrands(widget.cycleData.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            GetCycleBrandsModel cycle = snapshot.data;
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
                        Text("List Of Brands"),
                      ],),
                      ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text("${cycle.data![index].brandName}"),
                            subtitle: Text("No Of Bikes : ${cycle.data![index].noOfBike}\nRate : ${cycle.data![index].rate}/${cycle.data![index].type}"),
                            trailing: Icon(Icons.more_vert),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                FloatingActionButton(onPressed: () async {
                 var data = await Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCyclingBrands(cycleData: widget.cycleData,)));
                 if(data == true){
                   setState(() {

                   });
                 }else{
                   UtilityHlepar.getToast("No Change");
                 }
                } , child: Icon(Icons.add),)
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
