import 'package:deffo/Screen/Eco-Feel%20Page/eco_feel_search.dart';
import 'package:deffo/api/PushNotificationService.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/view/bottom_sheet/search_bottom_sheet.dart';
import 'package:deffo/view/home_page/eco_stay_page/eco_stay_page.dart';
import 'package:deffo/view/home_page/search/search.dart';
import 'package:deffo/view/home_page/ui_view/area_list_view.dart';
import 'package:deffo/view/home_page/ui_view/hotel_slider_image.dart';
import 'package:deffo/view/home_page/ui_view/running_view.dart';
import 'package:deffo/view/home_page/ui_view/title_view.dart';
import 'package:flutter/material.dart';

import '../fitness_app_theme.dart';

class EcoFeelPage extends StatefulWidget {
  const EcoFeelPage({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;

  @override
  _EcoFeelPageState createState() => _EcoFeelPageState();
}

class _EcoFeelPageState extends State<EcoFeelPage>
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
    registerToken();
  }
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  registerToken()async{
    await App.init();
    Map data = {
      "user_id": App.localStorage.getString("userid"),
      "device_id" : fcmToken,
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("update_Fcm_token_user"), data);
    if(response['status']){

    }else{

    }

  }
  void addAllListData() {
    const int count = 5;
    listViews.add(
      HotelSliderImage(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );
    // listViews.add(
    //   WorkoutView(
    //     animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //         parent: widget.animationController!,
    //         curve:
    //             Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
    //     animationController: widget.animationController!,
    //   ),
    // );
    listViews.add(
      TitleView(
        titleTxt: 'EcoFeel Categories',
        subTxt: '',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 4, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      AreaListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: widget.animationController!,
                curve: Interval((1 / count) * 5, 1.0,
                    curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController!,
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
      RunningView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve:
                Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
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
            ),
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
          return ListView.builder(
            controller: scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  55,
              bottom: 100 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController?.forward();
              return Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  listViews[index],
                ],
              );
            },
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
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
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
                      Row(
                        children: [
                          // SizedBox(width: width*.03,),
                          Expanded(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EcoFeelSearchPage(
                                      title: "",
                                    )));
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
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
