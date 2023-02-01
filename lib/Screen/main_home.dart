import 'package:deffo/Screen/Eco-stay%20Page/eco_stay_home.dart';
import 'package:deffo/api/PushNotificationService.dart';
import 'package:deffo/api/api_path.dart';import 'package:deffo/view/design_course/home_design_course.dart';
import 'package:deffo/view/home_page/eco_feel/eco_feel_home_page.dart';
import 'package:deffo/view/home_page/models/tabIcon_data.dart';
import 'package:deffo/view/home_page/profile/my_profile.dart';
import 'package:deffo/widgets/chat_screen.dart';
import 'package:flutter/material.dart';
import '../view/home_page/bottom_navigation_view/bottom_bar_view.dart';
import '../view/home_page/fitness_app_theme.dart';
import '../view/home_page/eco_stay_page/eco_stay_page.dart';


class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = EcoStayHomePage();
    super.initState();
    PushNotificationService pushNotificationService = new PushNotificationService(context: context,);
    pushNotificationService.initialise();
    registerToken();
  }

  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  registerToken()async{
    await App.init();
    Map data = {
      "user_id": App.localStorage.getString("userid"),
      "firebaseToken" : fcmToken,
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/update_fcm_user"), data);
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
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BookingPage()));
          },
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      EcoStayHomePage();
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      EcoFeelPage(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = ChatScreen(true);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody = MyProfilePage("User");
                });
              });
            }
          },
        ),
      ],
    );
  }
}
