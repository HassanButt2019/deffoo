import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Screen/Payment/Summary/hotel_summary.dart';
import 'package:deffo/api/Razorpay.dart';
import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/BookingModal.dart';
import 'package:deffo/model/request/get_profile_request.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HotelBooking extends StatefulWidget {
  final bookData;
  final hotelId;
  final hotelName;
  final hotelPrice;
  final hotelDetail;
  final hotelImage;
  String? roomNumber,memberNumber,startDate,endDate;
  String? room_id;
  HotelBooking(
      {this.bookData,
      this.hotelId,
      this.hotelName,
      this.hotelPrice,
      this.roomNumber,
      this.memberNumber,
      this.startDate,
      this.endDate,this.hotelImage,this.hotelDetail,this.room_id});

  @override
  State<HotelBooking> createState() => _HotelBookingState();
}

class _HotelBookingState extends State<HotelBooking> {
  var checkInController = TextEditingController();
  var checkOutController = TextEditingController();
  var checkInTimeController = TextEditingController();
  var checkOutTimeController = TextEditingController();
  var roomController = TextEditingController();
  var memberController = TextEditingController();
  var nameCon = TextEditingController();
  var phoneCon = TextEditingController();
  var emailCon= TextEditingController();
  var _n = 0;

  _hotelBooking() async {
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
                  var price = int.parse(widget.hotelPrice!=null?widget.hotelPrice:"10")*int.parse(widget.roomNumber.toString());
                  var data = widget.bookData;
                  var userId = "$user";
                  var hostId = "${data.hostId}";
                  var hotelCat = "${data.title}";
                  var hotelSubCat = "${widget.hotelName}";
                  var hotelCatId = "${data.id}";
                  var hotelSubCatId = "${widget.hotelPrice}";
                  var checkIn = widget.startDate.toString();
                  var checkOut = widget.endDate.toString();
                  var checkInTime = "${checkInTimeController.text}";
                  var checkOutTime = "${checkOutTimeController.text}";
                  var noOfGuest = "${widget.memberNumber}";
                  var amount = "$price";
                  var payment = "Cash";
                  BookingModal? model = await hotelBooking(
                      userId,
                      hostId,
                      hotelCat,
                      hotelSubCat,
                      hotelCatId,
                      hotelSubCatId,
                      checkIn,
                      checkOut,
                      checkInTime,
                      checkOutTime,
                      noOfGuest,
                      amount,
                      payment,nameCon.text,emailCon.text,phoneCon.text,data.propertyId,widget.room_id,widget.roomNumber);
                  if (model!.status == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HotelSummary( checkIn,
                          checkOut,
                          checkInTime,
                          checkOutTime,
                          noOfGuest,
                          amount,
                          payment,widget.hotelImage,nameCon.text,emailCon.text,phoneCon.text,noOfRoom: widget.roomNumber,)));
                  }
                },
                child: Text("Cash",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14.0),)),
            SizedBox(height: 10,),
            Divider(),
            SizedBox(height: 10,),
            InkWell(
                onTap: ()async{
                  Navigator.pop(context1);
                  var price = int.parse(widget.hotelPrice!=null?widget.hotelPrice:"10")*int.parse(widget.roomNumber.toString());
                  RazorPayHelper razorPay = new RazorPayHelper(price.toString(), context, (result)async{
                    if(result=="error"){

                    }else{
                      var user = await MyToken.getUserID();

                      var data = widget.bookData;
                      var userId = "$user";
                      var hostId = "${data.hostId}";
                      var hotelCat = "${data.title}";
                      var hotelSubCat = "${widget.hotelName}";
                      var hotelCatId = "${data.id}";
                      var hotelSubCatId = "${widget.hotelPrice}";
                      var checkIn = widget.startDate.toString();
                      var checkOut = widget.endDate.toString();
                      var checkInTime = "${checkInTimeController.text}";
                      var checkOutTime = "${checkOutTimeController.text}";
                      var noOfGuest = "${widget.memberNumber}";
                      var amount = "$price";
                      var payment = "Online";
                      BookingModal? model = await hotelBooking(
                          userId,
                          hostId,
                          hotelCat,
                          hotelSubCat,
                          hotelCatId,
                          hotelSubCatId,
                          checkIn,
                          checkOut,
                          checkInTime,
                          checkOutTime,
                          noOfGuest,
                          amount,
                          payment,nameCon.text,emailCon.text,phoneCon.text,data.propertyId,widget.room_id,widget.roomNumber);
                      if (model!.status == true) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => HotelSummary( checkIn,
                              checkOut,
                              checkInTime,
                              checkOutTime,
                              noOfGuest,
                              amount,
                              payment,widget.hotelImage,nameCon.text,emailCon.text,phoneCon.text,noOfRoom: widget.roomNumber,)));
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
  Future<void> _selectTime(BuildContext context,int i) async {
     TimeOfDay? picked_s = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), builder: (BuildContext? context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );});
    if(i==1){
      if (picked_s != null && picked_s != checkInTimeController.text ){
        setState(() {
          checkInTimeController.text = picked_s.hour.toString()+":"+picked_s.minute.toString();
        });
      }
    }else{
      if (picked_s != null && picked_s != checkOutTimeController.text ){
        setState(() {
          checkOutTimeController.text = picked_s.hour.toString()+":"+picked_s.minute.toString();
        });
      }
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.startDate.toString()));
    roomController.text = widget.roomNumber.toString();
    memberController.text = widget.memberNumber.toString();
    checkInController.text = DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.startDate.toString()));;
    checkOutController.text = DateFormat.yMMMMEEEEd().format(DateTime.parse(widget.endDate.toString()));;
  }
  GetProfileResponse? profileResponse;
  getProfile() async {
    try {
      String userid = await MyToken.getUserID();
      GetProfileRequest request = GetProfileRequest(userId: userid);
      profileResponse = await AuthApiHelper.getProfile(request);
      if (profileResponse!.status!) {
        setState(() {
          nameCon.text = profileResponse!.profile![0].firstname!;
          phoneCon.text = profileResponse!.profile![0].userPhone!;
          emailCon.text = profileResponse!.profile![0].userEmail!;
        });

      } else {

      }
    } catch (e) {

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking"),
      ),
      bottomSheet: ListTile(
        title: Text("₹${int.parse(widget.hotelPrice!=null?widget.hotelPrice:"10")*int.parse(widget.roomNumber.toString())}"),
        subtitle: Text("Inclusive of all Charges"),
        trailing: ElevatedButton(
          onPressed: () {
            if(validateField(nameCon.text, "Please Enter Full Name")!=null){
              setSnackbar("Please Enter Full Name", context);
              return;
            }
            if(validateMob(phoneCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number")!=null){
              setSnackbar(validateMob(phoneCon.text, "Please Enter Mobile Number","Please Enter Valid Mobile Number").toString(), context);
              return;
            }
            //
            if(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email")!=null){
              setSnackbar(validateEmail(emailCon.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
              return;
            }
            if(checkInTimeController.text==""||checkOutTimeController.text==""){
              setSnackbar("Please Select Time", context);
              return;
            }
            _hotelBooking();
          },
          child: Text("Book Now"),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: TextFormField(
              controller: nameCon,
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
              controller: phoneCon,
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
              controller: emailCon,
              decoration: const InputDecoration(
                icon: Icon(Icons.mail),
                hintText: 'Email Address',
                labelText: 'email',
              ),
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child:  DeffoTextField(
                    controller: checkInTimeController,
                    hint: "Check In Time",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child:  DeffoTextField(
                    controller: checkOutTimeController,
                    hint: "Check Out Time",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child:  DeffoTextField(
                    controller: checkInController,
                    hint: "Check In Time",
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DeffoTextField(
                    controller: checkOutController,
                    hint: "Check Out Time",
                  ),
                ),
              ],
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child:  DeffoTextField(
                    controller: checkInTimeController,
                    hint: "CheckIn Time",
                    readOnly: true,
                    onTap: (){
                      _selectTime(context, 1);
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child:DeffoTextField(
                    controller: checkOutTimeController,
                    hint: "CheckOut Time",
                    readOnly: true,
                    onTap: (){
                      _selectTime(context, 2);
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child:  DeffoTextField(
                    controller: roomController,
                    hint: "No. OF Rooms",
                    readOnly: true,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child:DeffoTextField(
                    controller: memberController,
                    hint: "No. of Members",
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),
          /*Column(
            children: [
              Text("No of Guests"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      if(_n>=1){
                        setState(() {
                          _n--;
                        });
                      }
                    },
                    child: Text("-"),
                  ),
                  Text("$_n"),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _n++;
                      });
                    },
                    child: Text("+"),
                  ),
                ],
              ),
            ],
          ),*/
          SizedBox(height: 20,),
          ListTile(
            title: Text("Property Rent"),
            trailing: Text("₹${int.parse(widget.hotelPrice!=null?widget.hotelPrice:"10")*int.parse(widget.roomNumber.toString())}"),
          ),
          ListTile(
            title: Text("Payable Amount"),
            trailing: Text("₹${int.parse(widget.hotelPrice!=null?widget.hotelPrice:"10")*int.parse(widget.roomNumber.toString())}"),
          )
        ],
      ),
    );
  }
}
