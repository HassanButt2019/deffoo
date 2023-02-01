import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 1),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  ListTile(title: Text("Deffo panel" , style: TextStyle(fontWeight: FontWeight.bold),),),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        leading:  CircleAvatar(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffABDCFF),
                                  Color(0xff0396FF),
                                ],
                              ),
                            ),
                          ),
                        ),
                        title: Text("Samantha James"),
                        subtitle: Text("Your Payment is successful"),
                        trailing: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xffD8D8D8),
                          child: Text("2", style: TextStyle(fontSize: 13 , color: Colors.black),),),
                      );
                    },
                  ),
                  ListTile(title: Text("EcoStay/EcoFeel" , style: TextStyle(fontWeight: FontWeight.bold),),),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        dense: true,
                        leading:  CircleAvatar(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffABDCFF),
                                  Color(0xff0396FF),
                                ],
                              ),
                            ),
                          ),
                        ),
                        title: Text("EcoStay/EcoFeel"),
                        subtitle: Text("Your Payment is successful"),
                        trailing: Text("25 Min Ago", style: TextStyle(fontSize: 10),),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
