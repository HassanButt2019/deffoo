import 'package:deffo/Screen/main_home.dart';
import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/request/resend_otp_request.dart';
import 'package:deffo/model/response/resend_otp_response.dart';
import 'package:deffo/token/token_string.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class OtpScreen extends StatefulWidget {
  String otp;
  String userid;
  String phoneNumber;
  OtpScreen(
      {Key? key,
      required this.otp,
      required this.phoneNumber,
      required this.userid})
      : super(key: key);
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late String otp;
  var inputOtp = null;
  var timerSeconds = 60;
  late bool resendOTP = false;
  // Controller
  CountdownController _controller = new CountdownController(autoStart: true);

  late ResendOtpResponse otpResponse;
  @override
  void initState() {
    super.initState();
    otp = widget.otp.toString();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.purple,
        title: Text("Enter Verification Code"),
      ),
      body: Container(
        height: height,
        child: AnimationLimiter(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(seconds: 1),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  SizedBox(
                    height: height * .03,
                  ),
                  Center(
                      child: Image.asset(
                    "assets/introduction_animation/logo.png",
                    scale: 3,
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                        "Please enter the verification code sent to\notp testing $otp"),
                  ),
                  Text("+91" + widget.phoneNumber,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: AppTheme.purple)),
                  SizedBox(
                    width: width * .5,
                    child: PinCodeTextField(
                      cursorColor: AppTheme.purple,
                      pinTheme: PinTheme(
                          inactiveColor: AppTheme.grey,
                          activeColor: AppTheme.purple,
                          selectedColor: AppTheme.grey),
                      keyboardType: TextInputType.number,
                      length: 4,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: Duration(milliseconds: 300),
                      onChanged: (value) {
                        inputOtp = value;
                        setState(() {});
                      },
                      appContext: context,
                    ),
                  ),
                  Column(
                    children: [
                      Text("Didn't Receive a text. Please wait"),
                      SizedBox(
                        height: height * .03,
                      ),
                      Countdown(
                        seconds: 60,
                        build: (BuildContext context, double time) => Column(
                          children: [
                            !resendOTP
                                ? Text(
                                    time.toInt().toString(),
                                    style: TextStyle(fontSize: 24),
                                  )
                                : TextButton(
                                    onPressed: () {
                                      print('Timer is done!');
                                      _controller.restart();
                                      resendOTP = false;
                                      resendOtp();
                                      setState(() {});
                                    },
                                    child: Text(
                                      "RESEND",
                                      style: TextStyle(color: AppTheme.purple),
                                    )),
                            Text('sec')
                          ],
                        ),
                        interval: Duration(milliseconds: 100),
                        controller: _controller,
                        onFinished: () {
                          resendOTP = true;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: InkWell(
                      onTap: () => verifyOTP(),
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 38),
                        child: Container(
                          height: 58,
                          width: width * .8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff552279),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// verify Otp
  verifyOTP() {
    if (otp.toString() == inputOtp.toString() && inputOtp != null) {
      setTokenData();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainHomePage()),
          (route) => false);

      UtilityHlepar.getToast(ToastString.msgVerifyOtp);
    } else {
      UtilityHlepar.getToast(ToastString.msgValidOtp);
    }
  }

// resend Otp
  resendOtp() async {
    ResendOtpRequest request = ResendOtpRequest(phone: widget.phoneNumber);
    otpResponse = await AuthApiHelper.resendOtp(request);
    otp = otpResponse.otp.toString();
    setState(() {});
  }

// set token data ()
  setTokenData() async {
    if (widget.userid != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(TokenString.userid, widget.userid);
    } else {
      UtilityHlepar.getToast(ToastString.msgSomeWentWrong);
    }
  }
}
