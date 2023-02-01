import 'package:deffo/Eco_Host/Create_Cycling/cycling_home.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_home.dart';
import 'package:deffo/Eco_Host/Create_tour/tour_home.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_home.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ListOfTypePage extends StatefulWidget {
  const ListOfTypePage({Key? key}) : super(key: key);

  @override
  State<ListOfTypePage> createState() => _ListOfTypePageState();
}

class _ListOfTypePageState extends State<ListOfTypePage> {
  var columnCount = 2;

  List type = [
    "Property",
    "Track And Trails",
    "Cycling",
    "Festivals",
    "Tour Guides"
  ];
  List image = [
    "assets/ecostay/Homestay.png",
    "assets/ecofeel/Track and trails.png",
    "assets/ecofeel/Cycling.png",
    "assets/ecofeel/festivals.png",
    "assets/ecofeel/Tour guid.png",

  ];

  propertyRoute() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MainListProperties(
                  checkEdit: false,
                )));
  }

  trackRoute() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TrackAndTrailsPage(
                  edit: false,
                )));
  }

  cyclingRoute() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CyclingHome(
                  edit: false,
                )));
  }

  festivalRoute() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FestivalHome(
                  edit: false,
                )));
  }

  tourRoutes() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TourHome(
                  edit: false,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create your own"),
      ),
      body: AnimationLimiter(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: columnCount,
          children: List.generate(
            type.length,
            (int index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: columnCount,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          propertyRoute();
                        } else if (index == 1) {
                          trackRoute();
                        } else if (index == 2) {
                          cyclingRoute();
                        } else if (index == 3) {
                          festivalRoute();
                        } else if (index == 4) {
                          tourRoutes();
                        }
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Image.asset(image[index], scale: 6,)),
                            Expanded(child: Center(child: Text("${type[index]}")))],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
