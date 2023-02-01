import 'package:deffo/Screen/Eco-Feel%20Page/cycling/cycling_list.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/eco_feel_search.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/festival/festival_list.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/tours/tours_lists.dart';
import 'package:deffo/Screen/Eco-Feel%20Page/track%20and%20trails/track_and_trails_list.dart';
import 'package:deffo/Screen/Eco-feel%20Page/cycling/show_cycling_details.dart';
import 'package:flutter/material.dart';

import '../fitness_app_theme.dart';

class AreaListView extends StatefulWidget {
  const AreaListView(
      {Key? key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _AreaListViewState createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<String> areaListData = <String>[
    'assets/ecofeel/Track and trails.png',
    'assets/ecofeel/Cycling.png',
    'assets/ecofeel/festivals.png',
    'assets/ecofeel/Tour guid.png',
  ];
  List<String> title = <String>[
    'Tracks and Trails',
    'Cycling',
    'Festivals',
    'Tour guides',
  ];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        AnimatedBuilder(
          animation: widget.mainScreenAnimationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: widget.mainScreenAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List<Widget>.generate(
                      areaListData.length,
                      (int index) {
                        final int count = areaListData.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                            parent: animationController!,
                            curve: Interval((1 / count) * index, 1.0,
                                curve: Curves.fastOutSlowIn),
                          ),
                        );
                        animationController?.forward();
                        return AreaView(
                          title: title[index],
                          imagepath: areaListData[index],
                          animation: animation,
                          animationController: animationController!,
                        );
                      },
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 24.0,
                      crossAxisSpacing: 24.0,
                      childAspectRatio: 1.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class AreaView extends StatelessWidget {
  const AreaView({
    Key? key,
    this.imagepath,
    this.animationController,
    this.animation,
    this.title,
  }) : super(key: key);

  final String? imagepath;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final title;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.4),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  splashColor: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                  onTap: () {
                    print(title);
                    if(title == "Tracks and Trails"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>TrackAndTrailsListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>EcoFeelSearchPage(
                        title: "Tracks and Trails",
                      )));
                    }else if(title == "Cycling"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> CyclingListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoFeelSearchPage(
                        title: "Cycling",
                      )));
                    }else if(title =="Festivals"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> FestivalListPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoFeelSearchPage(
                          title: "Festivals"
                      )));
                    }else if(title == "Tour guides"){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> ToursListsPage()));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EcoFeelSearchPage(
                          title: "Tour guides"
                      )));
                    }
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          child: Image.asset(imagepath!),
                        ),
                      ),
                      Expanded(child: Text(title))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
