import 'package:deffo/view/eco_host/list_your_properties.dart';
import 'package:flutter/material.dart';

import '../fitness_app_theme.dart';

class GlassView extends StatelessWidget {
  final AnimationController? animationController;
  final Animation<double>? animation;

  const GlassView({Key? key, this.animationController, this.animation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: new Transform(
            transform: new Matrix4.translationValues(
                0.0, 30 * (1.0 - animation!.value), 0.0),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    print('List Your Property');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListYourPropertyPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 0, bottom: 0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FitnessAppTheme.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color:
                                        FitnessAppTheme.grey.withOpacity(0.4),
                                    offset: Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.topLeft,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  child: SizedBox(
                                    height: 74,
                                    child: AspectRatio(
                                      aspectRatio: 1.714,
                                      child: Image.asset(
                                        "assets/fitness_app/back.png",
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 100,
                                            right: 16,
                                            top: 16,
                                          ),
                                          child: Text(
                                            "List Your Properties\nEcoStay / EcoFeel",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily:
                                                  FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme
                                                  .nearlyDarkBlue,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: -40,
                          left: -10,
                          child: SizedBox(
                            width: 110,
                            height: 110,
                            child: Image.asset(
                              "assets/ecostay/Tree houses.png",
                              scale: 5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      child: Column(
                    children: [
                      Text(
                        "Advertisement Banner",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("assets/ecostay/banner.jpg"),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
