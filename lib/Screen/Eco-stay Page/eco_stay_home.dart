
import 'package:deffo/Eco_Host/Auth/host_login.dart';
import 'package:deffo/Eco_Host/property_listing.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_categories.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/Screen/Slider/home_slider.dart';
import 'package:deffo/view/home_page/eco_stay_page/eco_stay_page.dart';
import 'package:deffo/view/home_page/fitness_app_theme.dart';
import 'package:deffo/view/home_page/search/search.dart';
import 'package:flutter/material.dart';

class EcoStayHomePage extends StatefulWidget {
  const EcoStayHomePage({Key? key}) : super(key: key);

  @override
  _EcoStayHomePageState createState() => _EcoStayHomePageState();
}

class _EcoStayHomePageState extends State<EcoStayHomePage> {
  double topBarOpacity = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerPage(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
           /* Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
          ],
          title: Image.asset(
            "assets/ecostay/logo.png",
            scale: 6,
          ),
          bottom: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: Row(
              children: [
                // SizedBox(width: width*.03,),
                Expanded(
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SearchPage("Stay",title: "" ,id: "",)));
                        },
                        dense: true,
                        title: Text(
                          "Where do u like to Go !",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )),
                ),
              ],
            ),
          ),
          iconTheme: IconThemeData(color: AppTheme.purple),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomePageSliderView(),
              //Hotel Category
              EcoStayCategories(),
              //Recommended For you
              Container(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Recommended For You"),
                    ),
                    HomePageSliderView(),
                  ],
                ),
              ),
              //Property
              Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      showDialog(context: context, builder: (BuildContext ctx){
                        return Dialog(
                          child:Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("You need to login as host for listing property.",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w500),),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("Cancel",style: TextStyle(color: AppTheme.purple,fontSize: 16.0,fontWeight: FontWeight.w500),),
                                    ),
                                    TextButton(onPressed: (){
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HostLogin()));
                                    }, child: Text("Continue",style: TextStyle(color: AppTheme.purple,fontSize: 16.0,fontWeight: FontWeight.w500),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                        );
                      });
                      print('List Your Property');
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => MainListPropertis()));

                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, top: 0, bottom: 0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FitnessAppTheme.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color:
                                          FitnessAppTheme.grey.withOpacity(0.4),
                                      offset: Offset(1.1, 1.1),
                                      blurRadius: 10.0),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                    child: SizedBox(
                                      height: 74,
                                      child: AspectRatio(
                                        aspectRatio: 1.714,
                                        child: Image.asset(
                                          "assets/fitness_app/back.png",
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 100,
                                              right: 16,
                                              top: 16,
                                            ),
                                            child: Text(
                                              "List Your Properties\nEcoStay / EcoFeel",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: -40,
                            left: -10,
                            child: SizedBox(
                              width: 110,
                              height: 110,
                              child: Image.asset(
                                "assets/ecostay/Tree houses.png",
                                scale: 5,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Column(
                      children: [
                        Text(
                          "Advertisement Banner",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/ecostay/banner.jpg"),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
