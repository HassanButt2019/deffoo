import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Payment/Summary/hotel_summary.dart';
import 'package:deffo/api/Razorpay.dart';
import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/BookingModal.dart';
import 'package:deffo/model/request/get_profile_request.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import 'festivals_book_now.dart';

class CycleBooking extends StatefulWidget {
  final bookData;
  final price;
  final bikeId;
  final bikeName;  final cycle;
  final type;
  final startDate;
  final endDate;
  final memberNumber;

  const CycleBooking({Key? key, this.bookData, this.price, this.bikeId, this.bikeName, this.cycle, this.type, this.startDate, this.endDate, this.memberNumber}) : super(key: key);

  @override
  State<CycleBooking> createState() => _CycleBookingState();
}

class _CycleBookingState extends State<CycleBooking> {
  TextEditingController dateinput = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  int _n = 0;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    getProfile();
  }
  GetProfileResponse? profileResponse;
  getProfile() async {
    try {
      String userid = await MyToken.getUserID();
      GetProfileRequest request = GetProfileRequest(userId: userid);
      profileResponse = await AuthApiHelper.getProfile(request);
      if (profileResponse!.status!) {
        setState(() {
          nameController.text = profileResponse!.profile![0].firstname!;
          phoneController.text = profileResponse!.profile![0].userPhone!;
          emailController.text = profileResponse!.profile![0].userEmail!;
        });

      } else {

      }
    } catch (e) {

    }
  }
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) {
        _n--;
      }
    });
  }

  _bookNow() async {
    showDialog(context: context, builder: (context1){
      return Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10,),
            InkWell(
                onTap: ()async{
                  Navigator.pop(context1);
                  var user = await MyToken.getUserID();
                  var price = int.parse(widget.price) * _n;
                  var data = widget.bookData;
                  var userId = user;
                  var hostId = "${data.userId}";
                  var cycleId = "${data.id}";
                  var cycleName = "${data.activityName}";
                  var bikeId = "${widget.bikeId}";
                  var bikeName = "${widget.bikeName}";
                  var customerName = "${nameController.text}";
                  var email = "${emailController.text}";
                  var phone = "${phoneController.text}";
                  var date = "${dateinput.text}";
                  var amount = "$price";
                  var payment = "Online";
                  var noOfGuest = "$_n";
                  BookingModal? modal = await cycleBooking(
                      userId,
                      hostId,
                      cycleId,
                      cycleName,
                      bikeId,
                      bikeName,
                      customerName,
                      email,
                      phone,
                      date,
                      amount,
                      payment,
                      noOfGuest);
                  if (modal!.status == true) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => HotelSummary("","","","",noOfGuest,amount,payment,"",nameController.text,phoneController.text,emailController.text)));
                  } else {
                    UtilityHlepar.getToast(modal.meassge);
                  }
                },
                child: Text("Cash",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),)),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            InkWell(
                onTap: ()async{
                  Navigator.pop(context1);
                  var price = int.parse(widget.price) * _n;
                  RazorPayHelper razorPay = new RazorPayHelper(price.toString(), context, (result)async{
                    if(result=="error"){

                    }else{
                      var user = await MyToken.getUserID();
                      var data = widget.bookData;
                      var userId = user;
                      var hostId = "${data.userId}";
                      var cycleId = "${data.id}";
                      var cycleName = "${data.activityName}";
                      var bikeId = "${widget.bikeId}";
                      var bikeName = "${widget.bikeName}";
                      var customerName = "${nameController.text}";
                      var email = "${emailController.text}";
                      var phone = "${phoneController.text}";
                      var date = "${dateinput.text}";
                      var amount = "$price";
                      var payment = "Offline";
                      var noOfGuest = "$_n";
                      BookingModal? modal = await cycleBooking(
                          userId,
                          hostId,
                          cycleId,
                          cycleName,
                          bikeId,
                          bikeName,
                          customerName,
                          email,
                          phone,
                          date,
                          amount,
                          payment,
                          noOfGuest);
                      if (modal!.status == true) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HotelSummary("","","","",noOfGuest,amount,payment,"",nameController.text,phoneController.text,emailController.text)));
                      } else {
                        UtilityHlepar.getToast(modal.meassge);
                      }
                    }
                  });
                  razorPay.init();
                },
                child: Text("Online",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),)),
            SizedBox(height: 10,),
          ],
        ),
      );
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: (ListTile(
        title: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Amount ₹ ${int.parse(widget.price) * _n}",
                style: TextStyle(fontSize: 15, color: Colors.green),
              ),
            ),
          ],
        ),
        subtitle: Text("inclusive of all charges"),
        trailing: Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              onPressed: () {
                if(validateField(nameController.text, "Please Enter Full Name")!=null){
                  setSnackbar("Please Enter Full Name", context);
                  return;
                }
                if(validateMob(phoneController.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number")!=null){
                  setSnackbar(validateMob(phoneController.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number").toString(), context);
                  return;
                }
                //
                if(validateEmail(emailController.text, "Please Enter Email","Please Enter Valid Email")!=null){
                  setSnackbar(validateEmail(emailController.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
                  return;
                }
                if(_n==0){
                  setSnackbar("Please Add Member", context);
                  return;
                }
                _bookNow();
             /*   Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HotelSummary()));*/
              },
              child: Text(
                "Make Payment",
                style: TextStyle(fontSize: 12),
              )),
        ),
      )),
      appBar: AppBar(title: Text("CycleBooking"), elevation: 0.0),
      body: Center(
          child: Container(
              child: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Enter your name',
              labelText: 'Name',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              icon: Icon(Icons.phone),
              hintText: 'Enter Number',
              labelText: 'Phone',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              hintText: 'Email Address',
              labelText: 'email',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: TextField(
            controller: dateinput,
            //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly: true,
            //set it true, so that user will not able to edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                //you can implement different kind of Date Format here according to your requirement

                setState(() {
                  dateinput.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {
                print("Date is not selected");
              }
            },
          ),
        ),
        SizedBox(
          width: 10,
          height: 5,
        ),
        Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.person,
                color: Colors.grey,
                size: 24.0,
              ),
              SizedBox(
                width: 10,
                height: 5,
              ),
              Text(
                "Number of Person",
              ),
              const SizedBox(
                width: 20,
                height: 15,
              ),
              FloatingActionButton(
                onPressed: add,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white,
              ),
              Text('$_n', style: const TextStyle(fontSize: 20.0)),
              FloatingActionButton(
                onPressed: minus,
                child: const Icon(
                  Icons.remove,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
          height: 5,
        ),
      ]))),
    );
  }
}
