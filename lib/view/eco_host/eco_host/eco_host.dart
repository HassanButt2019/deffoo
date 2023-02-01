import 'package:deffo/Eco_Host/Auth/account_details.dart';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/add_account.dart';
import 'package:deffo/Eco_Host/property_listing.dart';
import 'package:deffo/Screen/Splash/splash_page.dart';
import 'package:deffo/api/PushNotificationService.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/main.dart';
import 'package:deffo/utility/showDialog.dart';
import 'package:deffo/view/eco_host/eco_host/eco_feel_mgmt.dart';
import 'package:deffo/view/eco_host/eco_host/eco_stay_mgmt.dart';
import 'package:deffo/view/eco_host/list_your_properties.dart';
import 'package:deffo/view/home_page/bottom_navigation_view/bottom_bar_view.dart';
import 'package:deffo/view/home_page/inbox/inbox_page.dart';
import 'package:deffo/view/home_page/models/meals_list_data.dart';
import 'package:deffo/view/home_page/models/tabIcon_data.dart';
import 'package:deffo/view/home_page/profile/edit_profile.dart';
import 'package:deffo/view/home_page/profile/my_profile.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EcoHost extends StatefulWidget {
  const EcoHost({Key? key}) : super(key: key);

  @override
  _EcoHostState createState() => _EcoHostState();
}

class _EcoHostState extends State<EcoHost> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;

  var title = [
    "EcoStay",
    "EcoFeel",
    "Profile",
    "Tutorials",
    "Inbox",
    "Property Edit",
    "Account",
  ];
  var image = [
    "assets/ecostay/Tree houses.png",
    "assets/ecofeel/Cycling.png",
    "assets/ecostay/Profile.png",
    "assets/ecostay/video-tutorial.png",
    "assets/ecostay/inbox-mail.png",
    "assets/ecostay/home (1).png",
    "assets/fitness_app/runner.png"
  ];
  _handleRoutes(index) async {
    if (index == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EcoStayMgmt()));
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => EcoFeelMgmt()));
    } else if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyProfilePage("Host")));
    } else if (index == 3) {
    } else if (index == 4) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InboxPage()));
    } else if (index == 5) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => PropertyListPage()));
    } else if (index == 6) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HostAccount()));
    }
  }

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    // tabBody = EcoStayPage(animationController: animationController);
    super.initState();
    registerToken();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  registerToken()async{
    await App.init();
    Map data = {
      "host_id": App.localStorage.getString("userid"),
      "firebaseToken" : fcmToken,
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/update_fcm_host"), data);
    if(response['status']){

    }else{

    }

  }
  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: DeffoAppBar(
          title: "EcoHost Booking Mgmt",
        ),
      ),
      body: AnimationLimiter(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(
              title.length,
              (int index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  columnCount: 2,
                  child: ScaleAnimation(
                    child: FadeInAnimation(
                      child: InkWell(
                        onTap: (){
                          _handleRoutes(index);
                        },
                        child: Card(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                             color: AppTheme.white,
                             /* gradient: LinearGradient(
                                colors: <HexColor>[
                                  HexColor(mealsListData[index + 3].startColor),
                                  HexColor(mealsListData[index + 3].endColor),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),*/
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        image[index],
                                        height: 100,
                                      ),
                                    ))),
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Center(child: Text(title[index]))),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                MYDialog.showAlertDialogWithTwobtn(context,
                    title: 'Do you want to logout ?',
                    body: "",
                    funtionName: () => logout());
              },
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.purple,
                  borderRadius: BorderRadius.circular(25),
                ),
                child:  Text(
                  "Logout".toUpperCase(),
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()),
            (route) => false);
  }
  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> BookingPage()));
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  // tabBody =
                  //     EcoStayPage(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  // tabBody =
                  //     EcoFeelPage(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  // tabBody = InboxPage();
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  // tabBody =
                  //     MyProfilePage();
                });
              });
            }
          },
        ),
      ],
    );
  }
}
