import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/eco_booking_model.dart';
import 'package:deffo/view/design_course/design_course_app_theme.dart';
import 'package:deffo/view/design_course/ecofeel_user_booking.dart';
import 'package:deffo/view/design_course/home_design_course.dart';
import 'package:deffo/view/design_course/models/category.dart';
import 'package:deffo/view/home_page/eco_stay_page/booking_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CategoryListView extends StatefulWidget {
  var bookingList;
  String type;
   CategoryListView(this.type,{Key? key, this.callBack,required this.bookingList}) : super(key: key);

  final Function()? callBack;
  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.bookingList.length>0?Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Container(
        height: 134,
        width: double.infinity,
        child: ListView.builder(
          padding: const EdgeInsets.only(
              top: 0, bottom: 0, right: 16, left: 16),
          itemCount: widget.bookingList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final int count = Category.categoryList.length > 10
                ? 10
                : Category.categoryList.length;
            final Animation<double> animation =
            Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(
                    parent: animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn)));
            animationController?.forward();

            return widget.type=="stay"?CategoryView(
              category: widget.bookingList[index],
              animation: animation,
              animationController: animationController,
              callback: widget.callBack,
            ):CategoryView1(
              category: widget.bookingList[index],
              animation: animation,
              animationController: animationController,
              callback: widget.callBack,
            );
           /* return CategoryView(
              category: Category.categoryList[index],
              animation: animation,
              animationController: animationController,
              callback: widget.callBack,
            );*/
          },
        ),
      ),
    ):Center(child: Text("No Data"));
  }
}

class CategoryView extends StatelessWidget {
   CategoryView(
      {Key? key,
      this.category,
      this.animationController,
      this.animation,
      this.callback,this.proImage})
      : super(key: key);

  final VoidCallback? callback;
  final EcoBookingModel? category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  var proImage;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FutureBuilder(
            future: getPropertyImage1(category!.propertyId),
            builder: (BuildContext context,
                AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var proImage = snapshot.data;
                return FadeTransition(
                  opacity: animation!,
                  child: Transform(
                    transform: Matrix4.translationValues(
                        100 * (1.0 - animation!.value), 0.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      onTap: (){
                        Navigator.push<dynamic>(
                          context,
                          MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => EcoBookingDetails(model: category,image:"${proImage.path}/${proImage.data.propertyImage}",type: category!.complteBooking=="1"?"Completed":"Cancelled",),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 290,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48,
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: const Offset(4, 0),
                                            blurRadius: 3,
                                            spreadRadius: 0.0,
                                          ),
                                        ],
                                        color: Colors.grey.shade50,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16.0)),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          const SizedBox(
                                            width: 48 + 24.0,
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    category!.title.toString(),
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: AppTheme.purple),
                                                  ),
                                                  Text(
                                                    category!.address.toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        "${DateFormat.yMEd().format(DateTime.parse(category!.createDate.toString()))}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.all(8.0),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                "Book Again",
                                                                style: TextStyle(
                                                                    fontSize: 10),
                                                              ),
                                                              CircleAvatar(
                                                                  backgroundColor:
                                                                  AppTheme.purple,
                                                                  radius: 12,
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors.white,
                                                                  ))
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 16, left: 16, bottom: 10),
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
                                        aspectRatio: .8,
                                        child: InkWell(
                                          //  onTap: callback,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "${proImage.path}/${proImage.data.propertyImage}"))),
                                          ),
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
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback? callback;
   var category;
  final AnimationController? animationController;
  final Animation<double>? animation;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation!.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: (){
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => EcoFeelUserDetails(model:category),
                  ),
                );
              },
              child: SizedBox(
                width: 290,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 48,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(4, 0),
                                    blurRadius: 3,
                                    spreadRadius: 0.0,
                                  ),
                                ],
                                color: Colors.grey.shade50,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 48 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            category.activityName.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.purple),
                                          ),
                                          Text(
                                            category.address.toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${DateFormat.yMEd().format(DateTime.parse(category.createdAt.toString()))}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                    FontWeight.w600),
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Book Again",
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                      CircleAvatar(
                                                          backgroundColor:
                                                          AppTheme.purple,
                                                          radius: 12,
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 16, left: 16, bottom: 10),
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
                                aspectRatio: .8,
                                child: InkWell(
                                  //  onTap: callback,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "${imagePath+category.image}"))),
                                  ),
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

      },
    );
  }
}