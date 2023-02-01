import 'dart:async';

import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:deffo/api/api_helper/home_helper.dart';
import 'package:deffo/model/response/category_response.dart';
import 'package:deffo/utility/custom_widget.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/home_page/fitness_app_theme.dart';
import 'package:deffo/view/home_page/search/search.dart';

import 'package:deffo/view/shimmer_loding_view/loding_all_page.dart';
import 'package:deffo/view/shimmer_loding_view/loding_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class EcoStayCategories extends StatefulWidget {
  EcoStayCategories({Key? key}) : super(key: key);

  @override
  State<EcoStayCategories> createState() => _EcoStayCategoriesState();
}

class _EcoStayCategoriesState extends State<EcoStayCategories> {
  late Color colorName;
  StreamController<CategoryResponse> categoryStream = StreamController();
  late CategoryResponse categoryResponse;

  @override
  void initState() {
    super.initState();
    getHomeCategory();
  }

  @override
  void dispose() {
    super.dispose();
    categoryStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return StreamBuilder<CategoryResponse>(
        stream: categoryStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 5.0,
                    child: LodingSliderView()));
          }
          return Container(
            child: Column(
              children: [
                ListTile(
                  title: Text("EcoStay Categories"),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: AnimationLimiter(
                    child: GridView.count(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!.data!.map((model) {
                        int index = snapshot.data!.data!.indexWhere((element) => element.id==model.id);
                        return  AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 750),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: SlideAnimation(
                              child:  InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SearchPage("Stay",title: model.title,id: model.id,)));

                                },
                                child: AreaList(
                                  title: model.title,
                                  imagepath: snapshot.data!.baseUrl.toString()+model.image.toString(),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 24.0,
                      crossAxisSpacing: 24.0,
                      childAspectRatio: 1.0,
                    ),
                  ),
                ),

              /*  Container(
                  height: MediaQuery.of(context).size.height / 4,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        colorName = Color(
                                (math.Random().nextDouble() * 0xFF1a237e)
                                    .toInt())
                            .withOpacity(1.0);
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 750),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: SlideAnimation(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EcoStayListPage(
                                                hotelType: snapshot
                                                    .data!.data![index].title,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 20),
                                        child: Card(
                                          elevation: 6,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(40))
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: <BoxShadow>[],
                                              // gradient: LinearGradient(
                                              //   colors: [
                                              //     colorName.withOpacity(0.4),
                                              //     colorName
                                              //   ],
                                              //   begin: Alignment.topLeft,
                                              //   end: Alignment.bottomRight,
                                              // ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomRight: Radius.circular(8.0),
                                                bottomLeft: Radius.circular(8.0),
                                                topLeft: Radius.circular(8.0),
                                                topRight: Radius.circular(54.0),
                                              ),
                                            ),
                                            width: 110,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -5,
                                        left: -5,
                                        child: Container(
                                          width: 84,
                                          height: 84,
                                          decoration: BoxDecoration(
                                            color: FitnessAppTheme.nearlyWhite
                                                .withOpacity(0.2),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: -5,
                                        left: 8,
                                        child: Container(
                                          height: 80,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: CustomImage(
                                           url: snapshot.data!.baseUrl
                                               .toString() +
                                               snapshot
                                                   .data!.data![index].image
                                                   .toString(),
                                          )



                                          // UtilityHlepar.convertIMG(
                                          //     snapshot.data!.baseUrl
                                          //             .toString() +
                                          //         snapshot
                                          //             .data!.data![index].image
                                          //             .toString(),
                                          //     height: mysize.height / 20,
                                          //     fit: BoxFit.contain),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 35,),
                                            Text(
                                              UtilityHlepar.convertNA(
                                                  snapshot.data!.data![index].title),
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextStyle(color: Colors.black , fontSize: 16, fontWeight:  FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),*/
              ],
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
class AreaList extends StatelessWidget {
  const AreaList({
    Key? key,
    this.imagepath,
    this.title,
  }) : super(key: key);

  final String? imagepath;

  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 16,bottom: 10),
                child: CachedNetworkImage(
                    imageUrl:imagepath!,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey.shade300,
                      child: Image.asset("assets/introduction_animation/logo.png" , color: Colors.grey, scale: 2,)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Expanded(child: Text(title))
          ],
        ),
      ),
    );
  }
}