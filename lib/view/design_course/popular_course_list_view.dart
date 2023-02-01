import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/eco_booking_model.dart';
import 'package:deffo/view/design_course/course_info_screen.dart';
import 'package:deffo/view/design_course/design_course_app_theme.dart';
import 'package:deffo/view/design_course/ecofeel_user_booking.dart';
import 'package:deffo/view/design_course/home_design_course.dart';
import 'package:deffo/view/design_course/models/category.dart';
import 'package:deffo/view/home_page/eco_stay_page/booking_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class PopularCourseListView extends StatefulWidget {
  var bookingList;
  String type;
  PopularCourseListView(this.type,{Key? key, this.callBack,required this.bookingList}) : super(key: key);

  final Function()? callBack;
  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: widget.bookingList.length>0?GridView(
        padding: const EdgeInsets.all(8),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List<Widget>.generate(
          widget.bookingList.length,
              (int index) {
            final int count = widget.bookingList.length;
            final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: animationController!,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn),
              ),
            );
            animationController?.forward();
            return widget.type=="stay"?CategoryView(
              callback: widget.callBack,
              category: widget.bookingList[index],
              animation: animation,
              animationController: animationController,
            ):CategoryView1(
              callback: widget.callBack,
              category: widget.bookingList[index],
              animation: animation,
              animationController: animationController,
            );
          },
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 32.0,
          crossAxisSpacing: 32.0,
          childAspectRatio: 0.8,
        ),
      ):Center(child: Text("No Data")),
    );
  }
}

class CategoryView extends StatelessWidget {
   CategoryView(
      {Key? key,
      required this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final EcoBookingModel category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  Map data = {
    "Pending":Colors.orange,
    "Confirmed":Colors.yellow,
    "Cancelled":Colors.red,
    "Complete":Colors.green,
  };
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        String status = "Pending";
        if(category.confirmCancel.toString()=="0"){
          status = "Pending";
        }else if(category.confirmCancel.toString()=="1"){
          status = "Confirmed";
        }else if(category.confirmCancel.toString()=="2"&&category.confirmCancel.toString()=="3"){
          status = "Cancelled";
        }
        return FutureBuilder(
            future: getPropertyImage1(category.propertyId),
            builder: (BuildContext context,
                AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var proImage = snapshot.data;
                return FadeTransition(
                  opacity: animation!,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        0.0, 50 * (1.0 - animation!.value), 0.0),
                    child: InkWell(
                      onTap: ()async{
                        var result=await Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EcoBookingDetails(model: category,image:"${proImage.path}/${proImage.data.propertyImage}",type: "Upcoming",),
                          ),
                        );
                        if(result=="yes"){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => BookingPage()));
                        }
                      },
                      splashColor: Colors.transparent,
                      child: SizedBox(
                        height: 280,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: const Offset(3, 2),
                                      blurRadius: 3,
                                      spreadRadius: 0.0,
                                    ),
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                        // border: new Border.all(
                                        //     color: DesignCourseAppTheme.notWhite),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "${category.title}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppTheme.purple),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.location_on_outlined,
                                                        size: 16,
                                                        color: AppTheme.purple,
                                                      ),
                                                      Text(
                                                        "${category.address}",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    "${DateFormat.yMEd().format(DateTime.parse(category.createDate.toString()))}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.circle,
                                                        size: 16,
                                                        color: data[status],
                                                      ),
                                                      Text(
                                                        "$status",
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 5,),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 48,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 48,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                const EdgeInsets.only(top: 24, right: 16, left: 16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(16.0)),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: DesignCourseAppTheme.grey
                                              .withOpacity(0.2),
                                          offset: const Offset(0.0, 0.0),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                    const BorderRadius.all(Radius.circular(16.0)),
                                    child: AspectRatio(
                                        aspectRatio: 1.28,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      "${proImage.path}/${proImage.data.propertyImage}"))),
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Icon(Icons.error_outline);
              } else {
                return  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    elevation: 5,
                    child: Container(width: 100, height: 100, child: Shimmer.fromColors(
                        highlightColor: Colors.grey,
                        baseColor: Colors.white,
                        child: Image.asset("assets/introduction_animation/logo.png" , scale: 5,)),),),
                );
              }
            });

      },
    );
  }
}
class CategoryView1 extends StatelessWidget {
  CategoryView1(
      {Key? key,
        required this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback? callback;
  var category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  Map data = {
    "Pending":Colors.orange,
    "Confirmed":Colors.yellow,
    "Cancelled":Colors.red,
    "Complete":Colors.green,
  };
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        String status = "Pending";
        if(category.confirmCancel.toString()=="0"){
          status = "Pending";
        }else if(category.confirmCancel.toString()=="1"){
          status = "Confirmed";
        }else if(category.confirmCancel.toString()=="2"&&category.confirmCancel.toString()=="3"){
          status = "Cancelled";
        }
        return   FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: InkWell(
              onTap: ()async{
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => EcoFeelUserDetails(model:category),
                  ),
                );
              },
              splashColor: Colors.transparent,
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: const Offset(3, 2),
                              blurRadius: 3,
                              spreadRadius: 0.0,
                            ),
                          ]),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${category.activityName}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.purple),
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 16,
                                                color: AppTheme.purple,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${category.address}",
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            "${DateFormat.yMEd().format(DateTime.parse(category.createdAt.toString()))}",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(height: 5,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 16,
                                                color: data[status],
                                              ),
                                              Text(
                                                "$status",
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              "${imagePath+category.image}"))),
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );;

      },
    );
  }
}