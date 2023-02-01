import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/Auth/host_login.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HostSignUp extends StatefulWidget {
  const HostSignUp({Key? key}) : super(key: key);

  @override
  State<HostSignUp> createState() => _HostSignUpState();
}

class _HostSignUpState extends State<HostSignUp> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.purple,
        title: Text("Host Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  constraints:
                  BoxConstraints(maxWidth: 350, maxHeight: 250),
                  child: Image.asset(
                    'assets/introduction_animation/img 4.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 40,),
                makeInput(nameCon,TextInputType.name,label: "Name"),
                makeInput(mobileCon,TextInputType.phone,label: "Mobile No"),
                makeInput(emailCon,TextInputType.emailAddress,label: "Email"),
                makeInput(passCon,TextInputType.visiblePassword,label: "Password",obscureText: true),
                makeInput(cPassCon,TextInputType.visiblePassword,label: "Confirm Password",obscureText: true),
                InkWell(
                  onTap: () {
                    // if(validateField(nameCon.text, "Please Enter Full Name")!=null){
                    //   setSnackbar("Please Enter Full Name", context);
                    //   return;
                    // }
                    // if(validateMob(mobileCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number")!=null){
                    //   setSnackbar(validateMob(mobileCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number").toString(), context);
                    //   return;
                    // }
                    // //
                    // if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
                    //   setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                    //   return;
                    // }
                    // if(passCon.text==""||passCon.text.length<8){
                    //   setSnackbar("Minimum 8 character required", context);
                    //   return;
                    // }
                    // if(passCon.text!=cPassCon.text){
                    //   setSnackbar("Both Password doesn't Match", context);
                    //   return;
                    // }
                    // setState(() {
                    //   status =true;
                    // });
                    register();
                 //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HostLogin()));
                  },
                  child: Container(

                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppTheme.purple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  !status?Text(
                      "Login As Host".toUpperCase(),
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ):CircularProgressIndicator(color: AppTheme.white,),
                  ),
                ),
                SizedBox(height: 40,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text.rich(
                    TextSpan(
                        text: "Already have an account?",
                        children: [
                          TextSpan(
                            text: ' Login',
                            style: TextStyle(
                                color: AppTheme.purple,
                                fontWeight: FontWeight.w600,
                                fontSize: 18
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),

    );

  }
  TextEditingController mobileCon = new TextEditingController();
  TextEditingController passCon = new TextEditingController();
  TextEditingController emailCon = new TextEditingController();
  TextEditingController nameCon = new TextEditingController();
  TextEditingController cPassCon = new TextEditingController();
  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  register()async{
    // await App.init();
    // Map param = {
    //   "user_name":nameCon.text,
    //   "user_phone":mobileCon.text,
    //   "user_email":emailCon.text,
    //   "password":passCon.text,
    // };
    // Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/Authentication/create_host"), param);
    // setState(() {
    //   status= false;
    // });
    // setSnackbar(response['meassge'], context);
    // if(response['status']){
    //   App.localStorage.setString("userid", response['data']['id'].toString());
    //   App.localStorage.setString("name", response['data']['user_name'].toString());
    //   App.localStorage.setString("email", response['data']['user_phone'].toString());
    //   App.localStorage.setString("phone", response['data']['user_email'].toString());
    //   App.localStorage.setString("type", "Host".toString());
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EcoHost()), (route) => false);

   // }
  }
}

Widget makeInput(controller,keyboardType,{label,obscureText = false}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(label,style:TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87
      ),),
      SizedBox(height: 5,),
      TextField(
        obscureText: obscureText,
        controller: controller,
        keyboardType:keyboardType ,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0,horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),

          // border: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.grey)
          // ),
        ),
      ),
      SizedBox(height: 20,)

    ],
  );
}
