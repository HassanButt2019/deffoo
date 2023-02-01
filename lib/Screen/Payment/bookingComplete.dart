import 'package:deffo/Screen/main_home.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);
  @override
  State<Booking> createState() => _BookingState();
}
class _BookingState extends State<Booking> {

  Future<bool> onWill()async{
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainHomePage()), (route) => false);
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWill,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.green),
            onPressed: () =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainHomePage()), (route) => false),
          ),
          title: Text("Booking Now ",style: TextStyle(
              color: Colors.green
          ),),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(35.0),
                  child: Image.asset('assets/images/Group 52509.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text("Congratulations!!",style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Text("Your Payment Successful Congrats",style: TextStyle(fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                Container(
                  margin: EdgeInsets.all(30),
                  child: ElevatedButton(
                    child: Text('Submit', style: TextStyle(fontSize: 20.0),),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainHomePage()), (route) => false);

                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
