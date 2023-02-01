import 'dart:async';
import 'dart:developer';

import 'package:deffo/api/api_helper/home_helper.dart';
import 'package:deffo/main.dart';
import 'package:deffo/model/response/category_response.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/home_page/fitness_app_theme.dart';
import 'package:deffo/view/home_page/models/meals_list_data.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:deffo/view/shimmer_loding_view/loding_all_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HotelCategoryList extends StatefulWidget {
  const HotelCategoryList({
    Key? key,
    this.mainScreenAnimationController,
    this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController? mainScreenAnimationController;
  final Animation<double>? mainScreenAnimation;

  @override
  _HotelCategoryListState createState() => _HotelCategoryListState();
}

class _HotelCategoryListState extends State<HotelCategoryList>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<MealsListData> mealsListData = MealsListData.tabIconsList;
  StreamController<CategoryResponse> categoryStream = StreamController();
  late CategoryResponse categoryResponse;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
    getHomeCategory();
  }

  @override
  void dispose() {
    super.dispose();
    animationController?.dispose();
    categoryStream.close();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoryResponse>(
        stream: categoryStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingAllPage();
          }
          return AnimatedBuilder(
            animation: widget.mainScreenAnimationController!,
            builder: (BuildContext context, Widget? child) {
              return FadeTransition(
                opacity: widget.mainScreenAnimation!,
                child: Transform(
                  transform: Matrix4.translationValues(
                      0.0, 30 * (1.0 - widget.mainScreenAnimation!.value), 0.0),
                  child: Container(
                    height: 216,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 0, right: 16, left: 16),
                      itemCount: snapshot.data!.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final int count = snapshot.data!.data!.length > 10
                            ? 10
                            : snapshot.data!.data!.length;
                        final Animation<double> animation =
                            Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    parent: animationController!,
                                    curve: Interval((1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn)));
                        animationController?.forward();

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EcoStayListPage()));
                          },
                          child: MealsView(
                            categoryName:
                                snapshot.data!.data![index].title.toString(),
                            img: snapshot.data!.baseUrl! +
                                snapshot.data!.data![index].image.toString(),
                            mealsListData: mealsListData[index],
                            animation: animation,
                            animationController: animationController!,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  getHomeCategory() async {
    try {
      categoryResponse = await HomeAPiHelper.category();
      if (categoryResponse.status!) {
        categoryStream.sink.add(categoryResponse);
      } else {
        categoryStream.sink.addError(categoryResponse.message.toString());
      }
    } catch (e) {
      categoryStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key? key,
      this.mealsListData,
      this.animationController,
      this.animation,
      required this.categoryName,
      required this.img})
      : super(key: key);

  final MealsListData? mealsListData;
  final AnimationController? animationController;
  final Animation<double>? animation;
  final String img;
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mysize = MediaQuery.of(context).size;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: SizedBox(
              width: 130,
              // width: mysize.width / 1,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 32, left: 8, right: 8, bottom: 16),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor(mealsListData!.endColor)
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            // Colors.black12,
                            // Color((math.Random().nextDouble() * 0xFFFFFF)
                            //         .toInt())
                            //     .withOpacity(1.0),
                            HexColor(mealsListData!.startColor),
                            HexColor(mealsListData!.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 54, left: 16, right: 16, bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: height * .04,
                            ),
                            Text(
                              UtilityHlepar.convertNA(categoryName),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            // Expanded(
                            //   child: Padding(
                            //     padding:
                            //         const EdgeInsets.only(top: 8, bottom: 8),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.start,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: <Widget>[
                            //         Text(
                            //           mealsListData!.meals!.join('\n'),
                            //           style: TextStyle(
                            //             fontFamily: FitnessAppTheme.fontName,
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 10,
                            //             letterSpacing: 0.2,
                            //             color: FitnessAppTheme.white,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 84,
                      height: 84,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 8,
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: UtilityHlepar.convertIMG(img, fit: BoxFit.contain),
                      // child: Image.asset(
                      //   mealsListData!.imagePath,
                      //   scale: 1,
                      // ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NewHotelCategory extends StatefulWidget {
  final MealsListData? mealsListData;
  const NewHotelCategory({Key? key, this.mealsListData}) : super(key: key);

  @override
  State<NewHotelCategory> createState() => _NewHotelCategoryState();
}

class _NewHotelCategoryState extends State<NewHotelCategory> {
  StreamController<CategoryResponse> categoryStream = StreamController();
  late CategoryResponse categoryResponse;

  @override
  void dispose() {
    super.dispose();
    categoryStream.close();
  }

  @override
  void initState() {
    super.initState();
    getHomeCategory();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CategoryResponse>(
        stream: categoryStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Container(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingAllPage();
          }
          return Container(
            height: 216,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              padding:
                  const EdgeInsets.only(top: 0, bottom: 0, right: 16, left: 16),
              itemCount: snapshot.data!.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                final int count = snapshot.data!.data!.length > 10
                    ? 10
                    : snapshot.data!.data!.length;

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EcoStayListPage()));
                  },
                  child: MealsView(
                    categoryName: snapshot.data!.data![index].title.toString(),
                    img: snapshot.data!.baseUrl! +
                        snapshot.data!.data![index].image.toString(),
                    // mealsListData: mealsListData[index],
                  ),
                );
              },
            ),
          );
        });
  }

  getHomeCategory() async {
    try {
      categoryResponse = await HomeAPiHelper.category();
      if (categoryResponse.status!) {
        categoryStream.sink.add(categoryResponse);
      } else {
        categoryStream.sink.addError(categoryResponse.message.toString());
      }
    } catch (e) {
      categoryStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
