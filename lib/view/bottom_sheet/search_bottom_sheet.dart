import 'package:deffo/app_theme.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:flutter/material.dart';

class SearchBottomSheet extends StatefulWidget {
  @override
  _SearchBottomSheetState createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  var dropdownValue = "Near by Places";

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: mediaQueryData.viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: height * .03,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Enter Your Location"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Check in",
                            suffix: InkWell(
                                onTap: () {},
                                child: Icon(Icons.calendar_today))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Check Out",
                            suffix: InkWell(
                                onTap: () {},
                                child: Icon(Icons.calendar_today))),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration:
                            InputDecoration(hintText: "Number Of Person"),
                      ),
                    ),
                    SizedBox(
                      width: width * .02,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            suffix: Icon(Icons.arrow_drop_down_sharp),
                            hintText: "Near by Places"),
                      ),
                    ),
                  ],
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "List of places where EcoStays are available",
                      suffix: Icon(Icons.arrow_drop_down_sharp)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EcoStayListPage()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppTheme.purple,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Search",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
