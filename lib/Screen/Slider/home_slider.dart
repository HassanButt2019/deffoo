import 'dart:async';

import 'package:deffo/api/api_helper/home_helper.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/response/home_banner_response.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/view/shimmer_loding_view/loding_slider.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageSliderView extends StatefulWidget {
  // const HomePageSliderView({Key? key}) : super(key: key);
  @override
  _HomePageSliderViewState createState() => _HomePageSliderViewState();
}

class _HomePageSliderViewState extends State<HomePageSliderView> {
  late int _current = 0;
  late List sliderLenth = [];
  final CarouselController _controller = CarouselController();
  StreamController<HomeBannerResponse> bannerStream = StreamController();
  late HomeBannerResponse bannerResponse;
  @override
  void initState() {
    super.initState();
    gethomeBanner();
  }

  @override
  void dispose() {
    super.dispose();
    bannerStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return StreamBuilder<HomeBannerResponse>(
        stream: bannerStream.stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return LodingSliderView();
          }
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      height: mysize.height / 3.6,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      viewportFraction: 1.0,
                      aspectRatio: 1.0,
                      autoPlayAnimationDuration: Duration(milliseconds: 350),
                      autoPlayCurve: Curves.easeInCubic,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: sliderLenth.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          // height: 200,
                          // color: Colors.grey.withOpacity(0.4),
                          child: UtilityHlepar.convertIMG(
                              snapshot.data!.baseUrl! +
                                  snapshot.data!.data![i].sliderImage
                                      .toString(),
                              fit: BoxFit.contain,
                              width: mysize.width,
                              height: mysize.height / 3.5),
                          // child: Image.network(
                          // snapshot.data!.data![i].sliderImage.toString(),
                          //   fit: BoxFit.contain,
                          //   width: 600,
                          // ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.data!.data!.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white24),
                              color: (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppTheme.purple.withOpacity(0.5)
                                      : AppTheme.purple)
                                  .withOpacity(
                                      _current == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  gethomeBanner() async {
    try {
      bannerResponse = await HomeAPiHelper.homeBanner();
      if (bannerResponse.status!) {
        bannerStream.sink.add(bannerResponse);

        for (var i = 0; i < bannerResponse.data!.length; i++) {
          sliderLenth.add(i);
          print(i);
        }
      } else {
        bannerStream.sink.addError(bannerResponse.message.toString());
      }
    } catch (e) {
      bannerStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
