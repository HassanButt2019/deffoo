import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/Auth/host_login.dart';
import 'package:deffo/api/api_path.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HostAccount extends StatefulWidget {
  const HostAccount({Key? key}) : super(key: key);

  @override
  State<HostAccount> createState() => _HostAccountState();
}

class _HostAccountState extends State<HostAccount> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetail();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppTheme.purple,
        title: Text("Host Account Details"),
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
                makeInput(nameCon,TextInputType.name,label: "Account Name"),
                makeInput(passCon,TextInputType.visiblePassword,label: "Account Number",obscureText: true),
                makeInput(cPassCon,TextInputType.visiblePassword,label: "Confirm Account Number",obscureText: true),
                makeInput(mobileCon,TextInputType.text,label: "IFSC CODE"),
                makeInput(emailCon,TextInputType.emailAddress,label: "Bank Name"),
                makeInput(branchCon,TextInputType.emailAddress,label: "Branch Name"),
                InkWell(
                  onTap: () {
                    if(validateField(nameCon.text, "Please Enter Full Name")!=null){
                      setSnackbar("Please Enter Account Name", context);
                      return;
                    }
                    if(passCon.text==""||passCon.text.length<10){
                      setSnackbar("Please Enter Valid Account Number", context);
                      return;
                    }
                    if(passCon.text!=cPassCon.text){
                      setSnackbar("Both Account Number doesn't Match", context);
                      return;
                    }
                    if(mobileCon.text==""||mobileCon.text.length!=11){
                      setSnackbar("Please Enter Valid IFSC Code", context);
                      return;
                    }
                    if(validateField(emailCon.text, "Please Enter Full Name")!=null){
                      setSnackbar("Please Enter Bank Name", context);
                      return;
                    }
                    if(validateField(branchCon.text, "Please Enter Full Name")!=null){
                      setSnackbar("Please Enter Branch Name", context);
                      return;
                    }
                    setState(() {
                      status =true;
                    });
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
                      "Update Account".toUpperCase(),
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ):CircularProgressIndicator(color: AppTheme.white,),
                  ),
                ),
                SizedBox(height: 40,),
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
  TextEditingController branchCon = new TextEditingController();
  bool status = false;
  ApiBaseHelper apiBaseHelper = new ApiBaseHelper();
  register()async{
    await App.init();
    Map param = {
      "account_name":nameCon.text,
      "branch":branchCon.text,
      "ifsc_code":mobileCon.text,
      "bank_name":emailCon.text,
      "account_no":passCon.text,
      "host_id": App.localStorage.getString("userid"),
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/update_account_detail"), param);
    setState(() {
      status= false;
    });
    setSnackbar(response['meassge'], context);
    if(response['status']){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>EcoHost()), (route) => false);
    }
  }

  getDetail()async{
    await App.init();
    Map param = {
      "host_id": App.localStorage.getString("userid"),
    };
    Map response = await apiBaseHelper.postAPICall(Uri.parse("https://alphawizztest.tk/Deffo/api/authentication/get_account_detail"), param);
    setState(() {
      status= false;
    });
    setSnackbar(response['meassge'], context);
    if(response['status']){
      var data = response['data'];
      nameCon.text = data['account_name'];
      passCon.text = data['account_no'];
      cPassCon.text = data['account_no'];
      emailCon.text = data['bank_name'];
      mobileCon.text = data['ifsc_code'];
      branchCon.text = data['branch'];
    }
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
