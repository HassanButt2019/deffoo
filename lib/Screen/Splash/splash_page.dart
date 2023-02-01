
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:deffo/Screen/introduction_screen/introduction_animation_screen.dart';
import 'package:deffo/api/PushNotificationService.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/Screen/main_home.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var userid = null;
  @override
  void initState() {
    super.initState();
    PushNotificationService pushNotificationService = new PushNotificationService(context: context,);
    pushNotificationService.initialise();
    session();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      // backgroundColor: AppTheme.purple,
      splash: 'assets/introduction_animation/logo.png',
      duration: 4000,
      nextScreen:
          userid != null ? userid=="Host"?EcoHost():MainHomePage() : IntroductionAnimationScreen(),
      splashTransition: SplashTransition.fadeTransition,
      // pageTransitionType: PageTransitionType.scale,
    );
  }

  session() async {
    await App.init();
    if(App.localStorage.getString("type")=="Host"){
      setState(() {
        userid="Host";
      });
      return;
    }
    userid = await MyToken.getUserID();
    print("Login User id $userid");
    setState(() {});
  }
}
