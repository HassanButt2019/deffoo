import 'dart:async';

import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/api/privacy.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/request/get_profile_request.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/showDialog.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/Screen/Slider/home_slider.dart';
import 'package:deffo/view/bottom_sheet/search_bottom_sheet.dart';
import 'package:deffo/view/drawer_content/feedback_screen.dart';
import 'package:deffo/view/drawer_content/need_help_page.dart';
import 'package:deffo/Screen/main_home.dart';
import 'package:deffo/view/home_page/eco_stay_page/hotel_category_list.dart';
import 'package:deffo/view/home_page/profile/edit_profile.dart';
import 'package:deffo/view/home_page/search/search.dart';
import 'package:deffo/view/home_page/ui_view/glass_view.dart';
import 'package:deffo/view/home_page/ui_view/hotel_slider_image.dart';
import 'package:deffo/view/home_page/ui_view/title_view.dart';
import 'package:deffo/Screen/Splash/splash_page.dart';
import 'package:deffo/view/shimmer_loding_view/loding_slider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fitness_app_theme.dart';

class EcoStayPage extends StatefulWidget {
  const EcoStayPage({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _EcoStayPageState createState() => _EcoStayPageState();
}

class _EcoStayPageState extends State<EcoStayPage>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;

  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  double topBarOpacity = 0.0;

  searchBottomSheet(context) {
    showModalBottomSheet(
        enableDrag: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return SearchBottomSheet();
        });
  }

  int? selectDrawer = 1;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: widget.animationController!,
            curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn)));
    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;
    listViews.add(HomePageSliderView()
        // HotelSliderImage(
        //   animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        //       parent: widget.animationController!,
        //       curve:
        //           Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        //   animationController: widget.animationController!,
        // ),
        );
    listViews.add(
      TitleView(
        titleTxt: 'EcoStay Categories',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      HotelCategoryList(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 3, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Recommended For You',
        subTxt: '',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      HotelSliderImage(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    listViews.add(
      GlassView(
          animation: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                  parent: widget.animationController!,
                  curve: Interval((1 / count) * 8, 1.0,
                      curve: Curves.fastOutSlowIn))),
          animationController: widget.animationController!),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        drawer: DrawerPage(),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return Column(
            children: [
              ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.only(
                  top: AppBar().preferredSize.height +
                      MediaQuery.of(context).padding.top +
                      55,
                  bottom: 62 + MediaQuery.of(context).padding.bottom,
                ),
                itemCount: listViews.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  widget.animationController?.forward();
                  return Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      listViews[index],
                    ],
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return Stack(
              children: [
                Container(
                  height: 150,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.notifications),
                          ),
                        ],
                        title: Image.asset(
                          "assets/ecostay/logo.png",
                          scale: 6,
                        ),
                        iconTheme: IconThemeData(color: AppTheme.purple),
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 145,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.zero,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchPage("Stay",title: "" ,id: "",)));
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
                )
              ],
            );
          },
        )
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final onTap;
  final icon;
  final selectDrawer;
  final drawerIndex;
  final title;

  const CustomDrawer(
      {Key? key,
      this.onTap,
      this.icon,
      this.selectDrawer,
      this.drawerIndex,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: selectDrawer == drawerIndex
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
              Color(0xff4E1973),
              Color(0xff603181),
              Color(0xffFBEEFF),
            ]))
          : BoxDecoration(),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon,
            color:
                selectDrawer == drawerIndex ? Colors.white : AppTheme.purple),
        title: Text(
          "$title",
          style: selectDrawer == drawerIndex
              ? TextStyle(color: Colors.white)
              : TextStyle(),
        ),
      ),
    );
  }
}

class DrawerPage extends StatefulWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var selectDrawer = 1;
  late GetProfileResponse profileResponse;
  StreamController<GetProfileResponse> getProfileStream = StreamController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    getProfileStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Drawer(
      // backgroundColor: Color(0xffFBEEFF),
      child: Column(
        children: [
          StreamBuilder<GetProfileResponse>(
              stream: getProfileStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return SizedBox(
                    height: mysize.height / 10,
                    child: Center(
                      child: Container(
                        child: Text(snapshot.error.toString()),
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return LodingSliderView();
                }
                return DrawerHeader(
                    child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfilePage("User",
                                    getProfileResponse: snapshot.data,
                                  )));
                    });
                  },
                  child: Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(snapshot
                                  .data!.imgPath! +
                              snapshot.data!.profile![0].userImage.toString()),
                          radius: 50,
                        ),
                        Expanded(
                            child: ListTile(
                          title: Wrap(
                            children: [
                              Text(UtilityHlepar.convertNA(snapshot
                                  .data!.profile![0].firstname
                                  .toString())),
                              Icon(
                                Icons.edit_outlined,
                                size: 15,
                              )
                            ],
                          ),
                          subtitle: Text(
                            UtilityHlepar.convertNA(snapshot
                                    .data!.profile![0].userEmail
                                    .toString()) +
                                "\n" +
                                snapshot.data!.profile![0].userPhone.toString(),
                            softWrap: true,
                          ),
                        ))
                      ],
                    ),
                  ),
                ));
              }),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              // physics: ClampingScrollPhysics(),
              children: [
                ListTile(
                  title: Text(
                    "Support",
                    style: TextStyle(color: AppTheme.purple),
                  ),
                ),
                CustomDrawer(
                  title: "Need Help?",
                  selectDrawer: selectDrawer,
                  drawerIndex: 1,
                  icon: Icons.info_outline,
                  onTap: () {
                    setState(() {
                      selectDrawer = 1;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NeedHelpPage()));
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    "Legal",
                    style: TextStyle(color: AppTheme.purple),
                  ),
                ),
                CustomDrawer(
                  title: "Terms and Conditions",
                  selectDrawer: selectDrawer,
                  drawerIndex: 2,
                  icon: Icons.document_scanner,
                  onTap: () {
                    setState(() {
                      selectDrawer = 2;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicyView("terms-condition","Terms and Conditions")));
                  },
                ),
                CustomDrawer(
                  title: "Cancellation Policies",
                  selectDrawer: selectDrawer,
                  drawerIndex: 3,
                  icon: Icons.policy_outlined,
                  onTap: () {
                    setState(() {
                      selectDrawer = 3;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> PrivacyPolicyView("cancellation-policies","Cancellation Policies")));
                  },
                ),
                CustomDrawer(
                  title: "Feedback",
                  selectDrawer: selectDrawer,
                  drawerIndex: 4,
                  icon: Icons.feedback_outlined,
                  onTap: () {
                    setState(() {
                      selectDrawer = 4;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackScreen()));
                    });
                  },
                ),
                ListTile(
                  title: Text(
                    "Account",
                    style: TextStyle(color: AppTheme.purple),
                  ),
                ),
                // CustomDrawer(
                //   title: "Favourites",
                //   selectDrawer: selectDrawer,
                //   drawerIndex: 7,
                //   icon: Icons.favorite_border,
                //   onTap: (){
                //     setState(() {
                //       selectDrawer = 7;
                //       // Navigator.push(context, MaterialPageRoute(builder: (context)=> FavouritesPage()));
                //     });
                //   },
                // ),
                // Divider(),
                CustomDrawer(
                  title: "Logout",
                  selectDrawer: selectDrawer,
                  drawerIndex: 9,
                  icon: Icons.logout,
                  onTap: () {
                    MYDialog.showAlertDialogWithTwobtn(context,
                        title: 'Do you want to logout ?',
                        body: "",
                        funtionName: () => logout());
                  },
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  getProfile() async {
    try {
      String userid = await MyToken.getUserID();

      GetProfileRequest request = GetProfileRequest(userId: userid);
      print(request.tojson());
      print("===============");
      profileResponse = await AuthApiHelper.getProfile({"user_id":userid},url: "");
      if (profileResponse.status!) {
        getProfileStream.sink.add(profileResponse);
      } else {
        getProfileStream.sink.addError(profileResponse.message.toString());
      }
    } catch (e) {
      getProfileStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }

// logout
  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashPage()),
        (route) => false);
  }
}
