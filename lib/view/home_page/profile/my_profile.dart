import 'dart:async';

import 'package:deffo/Eco_Host/Auth/host_login.dart';
import 'package:deffo/api/api_helper/auth_helper.dart';
import 'package:deffo/model/request/get_profile_request.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/toast_string.dart';
import 'package:deffo/view/eco_host/eco_host/eco_host.dart';
import 'package:deffo/view/home_page/profile/edit_profile.dart';
import 'package:deffo/view/shimmer_loding_view/loding_all_page.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyProfilePage extends StatefulWidget {
  String type;

  MyProfilePage(this.type);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  var type = false;
  changeType() async {
    showDialog<void>(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Lorem Ipsum.....'),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             EcoHost())); // Dismiss alert dialog
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HostLogin())); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  late GetProfileResponse profileResponse;
  StreamController<GetProfileResponse> profileStream = StreamController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    super.dispose();
    profileStream.close();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: DeffoAppBar(
            title: "Account",
          ),
        ),
        body: StreamBuilder<GetProfileResponse>(
            stream: profileStream.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Container(
                    child: Text(snapshot.error.toString()),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return LodingAllPage();
              }
              var data = snapshot.data!.profile![0];
              return SingleChildScrollView(
                child: AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(seconds: 1),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        Container(
                          height: height * .3,
                          width: width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                Color(0xff4E1973),
                                Color(0xff603181),
                                Color(0xff774F95)
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "My Profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(
                                    snapshot.data!.imgPath.toString() +
                                        snapshot.data!.profile![0].userImage
                                            .toString()),
                              ),
                              Text(
                                data.firstname.toString().isNotEmpty
                                    ? data.firstname.toString()
                                    : "Welcome ${widget.type}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * .02,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text("Profile Details"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text("Name :")),
                                            Expanded(
                                              child: Text(
                                                data.firstname
                                                        .toString()
                                                        .isNotEmpty
                                                    ? data.firstname.toString()
                                                    : "None",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * .03,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(child: Text("Email :")),
                                            Expanded(
                                              child: Text(
                                                data.userEmail
                                                        .toString()
                                                        .isNotEmpty
                                                    ? data.userEmail.toString()
                                                    : "None",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * .03,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text("Phone No. :")),
                                            Expanded(
                                              child: Text(
                                                data.userPhone
                                                        .toString()
                                                        .isNotEmpty
                                                    ? data.userPhone.toString()
                                                    : "None",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * .03,
                        ),
                        InkWell(
                          onTap: () async {
                            var data = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfilePage(
                                          widget.type,
                                          getProfileResponse: snapshot.data,
                                        )));
                            print(data);
                            getProfile();
                            // setState(() {});
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
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )),
                        ),
                        /*ListTile(
                          title: Text(type ? "EcoHost" : "EcoGuest"),
                          trailing: CupertinoSwitch(
                              value: type,
                              onChanged: (value) {
                                changeType();
                                setState(() {
                                  type = !type;
                                });
                              }),
                        ),*/
                        SizedBox(
                          height: 150,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }

  getProfile() async {
    try {
      String userid = await MyToken.getUserID();
      GetProfileRequest request = GetProfileRequest(userId: userid);
      profileResponse = await AuthApiHelper.getProfile(widget.type=="User"?{"user_id":userid}:{"host_id":userid},url: widget.type!="User"?"https://alphawizztest.tk/Deffo/api/Authentication/getProfilehost":"");
      if (profileResponse.status!) {
        profileStream.sink.add(profileResponse);
      } else {
        profileStream.sink.addError(profileResponse.message.toString());
      }
    } catch (e) {
      profileStream.sink.addError(ToastString.msgSomeWentWrong);
    }
  }
}
