import 'package:deffo/Screen/introduction_screen/introduction_animation_screen.dart';
import 'package:deffo/view/design_course/home_design_course.dart';
import 'package:deffo/Screen/main_home.dart';
import 'package:deffo/Screen/Eco-stay%20Page/category/eco_stay_list.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: IntroductionAnimationScreen(),
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: EcoStayListPage(),
    ),
    HomeList(
      imagePath: 'assets/home_page/home_page.png',
      navigateScreen: MainHomePage(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: BookingPage(),
    ),
  ];
}
