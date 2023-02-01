// Project Screen

import 'package:deffo/Screen/Eco-stay%20Page/eco_stay_home.dart';
import 'package:deffo/Screen/Introduction_screen/introduction_animation_screen.dart';
import 'package:deffo/Screen/Slider/home_slider.dart';
import 'package:deffo/Screen/auth_page/login_page.dart';
import 'package:deffo/Screen/auth_page/otp_screen.dart';
import 'package:deffo/Screen/main_home.dart';
import 'package:deffo/main.dart';

///intro
final myApp = MyApp();
final introScreen = IntroductionAnimationScreen();
final mobileScreen = LoginPage();
final otpScreen = OtpScreen(otp: '', userid: '', phoneNumber: '',);
final mainHome = MainHomePage();

///EcoStay
final ecoHome = EcoStayHomePage();
final slider = HomePageSliderView();