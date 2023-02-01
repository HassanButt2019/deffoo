import 'package:deffo/Eco_Host/Auth/host_login.dart';
import 'package:deffo/Screen/auth_page/otp_screen.dart';
import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/request/login_with_phone_request.dart';
import 'package:deffo/model/response/login_with_otp_response.dart';
import 'package:deffo/validation/form_validation.dart';
import 'package:deffo/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> _fromKey = GlobalKey<FormState>();
  bool lodingbtn = false;
  late LoginResponse loginResponse;

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.purple,
        title: Text("Login"),
      ),
      body: Form(
        key: _fromKey,
        child: Container(
          // height: height,
          child: AnimationLimiter(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(seconds: 2),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Center(
                      child: Text(
                        "Login to Deffo Account",
                        style: TextStyle(
                            fontSize: 32.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      constraints:
                          BoxConstraints(maxWidth: 350, maxHeight: 350),
                      child: Image.asset(
                        'assets/introduction_animation/img 4.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        maxLength: 10,
                        autofocus: true,
                        validator: FormValidation.validateMobile,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixText: "+91  ", label: Text("Mobile Number")),
                      ),
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {
                          if (_fromKey.currentState!.validate()) {
                            lodingbtn = true;
                            setState(() {});
                            onTapLoin();
                          }
                        },
                        child: MyButton.myLodingButton(mysize,
                            lodingbtn: lodingbtn),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HostLogin()));
              },
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.purple,
                  borderRadius: BorderRadius.circular(25),
                ),
                child:  Text(
                  "Login As Host".toUpperCase(),
                  style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// Login with phone Number
  onTapLoin() async {
    LoginRequest request =
        LoginRequest(phone: phoneController.text, firebaseToken: "as");
    loginResponse = await AuthApiHelper.login(request);
    if (loginResponse.status!) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    phoneNumber: phoneController.text,
                    userid: loginResponse.userId.toString(),
                    otp: loginResponse.otp.toString(),
                  )));
    }
    lodingbtn = false;
    setState(() {});
  }
}
