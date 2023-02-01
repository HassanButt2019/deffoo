import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_details/eco_stay_details.dart';
import 'package:deffo/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EcoStayFilter extends StatefulWidget {
  const EcoStayFilter({Key? key}) : super(key: key);

  @override
  _EcoStayFilterState createState() => _EcoStayFilterState();
}

class _EcoStayFilterState extends State<EcoStayFilter> {
  var highToLow = false;
  var lowToHigh = false;
  List<bool> ratingList = [false,false,false,false];
  List<bool> amenList = [false,false,false,false,false];
  List<String> amnList = ["All","Internet","Toilet","Pet","Food"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Color(0xff4E1973),
                Color(0xff603181),
                Color(0xff774F95),
              ])),
        ),
      ),
      body: ListView(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      highToLow = false;
                      lowToHigh = false;
                      ratingList = [false,false,false,false];
                      amenList = [false,false,false,false,false,false];
                    });
                  },
                  child: Text(
                    "Clear",
                    style: TextStyle(color: Colors.red),
                  ))),
          Card(
            elevation: 4,
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Price",
                          style: TextStyle(
                              color: AppTheme.purple,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomListTile(
                  title: "High to Low",
                  onTap:()  {
                    setState(() {
                      lowToHigh = false;
                      highToLow = !highToLow;
                    });
                  },
                  value: highToLow,
                ),

                CustomListTile(
                  title: "Low to High",
                  onTap: () {
                    setState(() {
                      highToLow = false;
                      lowToHigh = !lowToHigh;
                    });
                  },
                  value: lowToHigh,
                ),
                Divider(),
                Card(
                  elevation: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Rating",
                          style: TextStyle(
                              color: AppTheme.purple,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomListTile(
                  title: "4.5 & above",
                  onTap: () {
                    setState(() {
                      for(int i =0;i<ratingList.length;i++){
                        if(i!=0){
                          ratingList[i]=false;
                        }
                      }
                      ratingList[0] = !ratingList[0];
                    });
                  },
                  value: ratingList[0],
                ),
                CustomListTile(
                  title: "4.0 & above",
                  onTap: () {
                    setState(() {
                      for(int i =0;i<ratingList.length;i++){
                        if(i!=1){
                          ratingList[i]=false;
                        }
                      }
                      ratingList[1] = !ratingList[1];
                    });
                  },
                  value: ratingList[1],
                ),
                CustomListTile(
                  title: "3.5 & above",
                  onTap: () {
                    setState(() {
                      for(int i =0;i<ratingList.length;i++){
                        if(i!=3){
                          ratingList[i]=false;
                        }
                      }
                      ratingList[3] = !ratingList[3];
                    });
                  },
                  value: ratingList[3],
                ),
                CustomListTile(
                  title: "3.0 & above",
                  onTap: () {
                    setState(() {
                      for(int i =0;i<ratingList.length;i++){
                        if(i!=2){
                          ratingList[i]=false;
                        }
                      }
                      ratingList[2] = !ratingList[2];
                    });
                  },
                  value: ratingList[2],
                ),
              ],
            ),
          ),
          Card(
            elevation: 4,
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Amenities",
                          style: TextStyle(
                              color: AppTheme.purple,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomListTile(
                  title: "All",
                  onTap: () {
                    for(int i =0;i<amenList.length;i++){
                      setState(() {
                        amenList[i]=!amenList[i];
                      });

                    }
                  },
                  value: amenList[0],
                ),
                CustomListTile(
                  title: "Internet Facility",
                  onTap: () {
                    setState(() {
                      amenList[1] = !amenList[1];
                    });
                  },
                  value: amenList[1],
                ),
                Divider(),
                CustomListTile(
                  title: "Attached Toilet",
                  onTap: () {
                    setState(() {
                      amenList[2] = !amenList[2];
                    });
                  },
                  value: amenList[2],
                ),
                CustomListTile(
                  title: "Pet Friendly",
                  onTap: () {
                    setState(() {
                      amenList[3] = !amenList[3];
                    });
                  },
                  value: amenList[3],
                ),
                CustomListTile(
                  title: "Fooding",
                  onTap: () {
                    setState(() {
                      amenList[4] = !amenList[4];
                    });
                  },
                  value: amenList[4],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              buttonTitle: "Apply",
              onTap: (){
                Map data = {

                };
                String amen = "";
                for(int i = 0;i<amenList.length;i++){
                  if(amenList[i]){
                    amen += amnList[i]+",";
                  }
                }
                for(int i = 0;i<ratingList.length;i++){
                  if(ratingList[i]){
                    if(i==0){
                      data['rating'] = "4.5";
                    }else if(i==1){
                      data['rating'] = "4.0";
                    }else if(i==3){
                      data['rating'] = "3.5";
                    }else{
                      data['rating'] = "3.0";
                    }
                  }
                }
                data['amen'] = amen;
                if(highToLow){
                  data['price'] = "high";
                }
                if(lowToHigh){
                  data['price'] = "low";
                }
                Navigator.pop(context,data);
              },
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final title;

  final leading;

  final trailing;

  final value;

  final onTap;

  const CustomListTile(
      {Key? key,
      this.title,
      this.leading,
      this.trailing,
      this.value,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      onTap: onTap,
      leading: leading,
      trailing: Icon(value?Icons.radio_button_checked_sharp:Icons.radio_button_unchecked,size: 24.0,color: Color(0xff4E1973),),
    );
  }
}
