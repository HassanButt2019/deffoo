import 'package:deffo/widgets/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NeedHelpPage extends StatefulWidget {
  @override
  _NeedHelpPageState createState() => _NeedHelpPageState();
}

class _NeedHelpPageState extends State<NeedHelpPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Need Help ?"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Color(0xff4E1973),
                    Color(0xff603181),
                    Color(0xff774F95),
                  ])),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(height: 10,),
        Image.asset("assets/images/Group 52509.png", scale: 6,),
        SizedBox(height: 10,),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(false)));
          },
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
                      Icon(Icons.chat_bubble_outline , color: Colors.white,),
                      Text(
                        "Chatbot",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )),
        ),
        InkWell(
          onTap: () {
            launch("tel://1234567890");
          },
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
                      Icon(Icons.call , color: Colors.white,),
                      Text(
                        "Call Me",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )),
        ),
        InkWell(
          onTap: () {
            launch("mailto:test1@gmail.com");
          },
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
                      Icon(Icons.email_outlined , color: Colors.white,),
                      Text(
                        "Email Id",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ],),
    );
  }
}
