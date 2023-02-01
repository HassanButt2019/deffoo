import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_home.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateTrackGeneralModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class TrackAndTrailsGeneral extends StatefulWidget {
  final edit;
  final trackData;
  const TrackAndTrailsGeneral({Key? key, this.edit, this.trackData}) : super(key: key);

  @override
  _TrackAndTrailsGeneralState createState() => _TrackAndTrailsGeneralState();
}

class _TrackAndTrailsGeneralState extends State<TrackAndTrailsGeneral> {
  List trackItems = [
    {
      "id": 1,
      "title": "Head Torch",
      "image": "assets/trackTrails/Head Torch.png"
    },
    {
      "id": 2,
      "title": "Rain Coat",
      "image": "assets/trackTrails/Rain coat.png"
    },
    {
      "id": 3,
      "title": "Warm Clothes",
      "image": "assets/trackTrails/Warm Cloths.png"
    },
    {"id": 4, "title": "Caps", "image": "assets/trackTrails/Caps.png"},
    {"id": 5, "title": "Hats", "image": "assets/trackTrails/Hats.png"},
    {
      "id": 6,
      "title": "Extra Socks",
      "image": "assets/trackTrails/Extra Socks.png"
    },
    {
      "id": 7,
      "title": "Jackets & Thermals",
      "image": "assets/trackTrails/Jacket & Thermals.png"
    },
    {
      "id": 8,
      "title": "Tracking Shoes",
      "image": "assets/trackTrails/Trekking Shoes.png"
    },
    {
      "id": 9,
      "title": "Mosquito & Repellent",
      "image": "assets/trackTrails/Mosquito & Insect.png"
    },
    {"id": 10, "title": "Rucksack", "image": "assets/trackTrails/Rucksak.png"},
    {
      "id": 11,
      "title": "Water Bottle",
      "image": "assets/trackTrails/Water Bottle.png"
    },
    {
      "id": 12,
      "title": "Sun Screen",
      "image": "assets/trackTrails/Sunscreem.png"
    },
    {
      "id": 13,
      "title": "Sun Glasses",
      "image": "assets/trackTrails/Sunglasses.png"
    },
    {"id": 14, "title": "Camera", "image": "assets/trackTrails/Camers.png"},
    {
      "id": 15,
      "title": "Comfortable Clothes",
      "image": "assets/trackTrails/Comfortable Cloths.png"
    },
    {"id": 16, "title": "Towels", "image": "assets/trackTrails/Towels.png"},
    {
      "id": 17,
      "title": "Medical Kit",
      "image": "assets/trackTrails/Medical Kit.png"
    },
    {"id": 18, "title": "Snacks", "image": "assets/trackTrails/Snacks.png"},
    {
      "id": 19,
      "title": "Energy Bars",
      "image": "assets/trackTrails/Energy Bars.png"
    },
    {
      "id": 20,
      "title": "Toilet Paper & Wipes",
      "image": "assets/trackTrails/Toilet Paper & Wipes.png"
    },
  ];

  List chooseItem = [];

  var addOnController = TextEditingController();

  _createTrackGenerals() async {
    try {
      var trackId = "${widget.trackData.id}";
      var items = chooseItem.toString();
      var addOn = "${addOnController.text}";
      CreateTrackGeneralModel? model =
          await createTrackGeneral(trackId, items, addOn);
      if(model!.status == true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrackAndTrailsPage(index: 2, edit: widget.edit, trackData: widget.trackData,)));
      }
    } catch (e) {
      UtilityHlepar.getToast("something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        GridView.count(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          crossAxisCount: 4,
          children: trackItems
              .asMap()
              .entries
              .map<Widget>((e) => InkWell(
                    onTap: () {
                      if (chooseItem.contains(e.value["title"])) {
                        setState(() {
                          chooseItem.remove(e.value["title"]);
                        });
                      } else {
                        setState(() {
                          chooseItem.add(e.value["title"]);
                        });
                      }
                      print(chooseItem);
                    },
                    child: Card(
                      color: chooseItem.contains(e.value["title"])
                          ? AppTheme.purple
                          : Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                              child: Center(
                            child: Image.asset(
                              e.value["image"],
                              color: chooseItem.contains(e.value["title"])
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          )),
                          Expanded(
                              child: Center(
                            child: Text(
                              "${e.value["title"]}",
                              style: TextStyle(
                                  color: chooseItem.contains(e.value["title"])
                                      ? AppTheme.white
                                      : Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: height / 120),
              child: Text(
                "Things To carry (Add - On)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppTheme.purple),
              ),
            ),
            TextField(
              controller: addOnController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _createTrackGenerals();
                    },
                    child: Text("Save"))),
            SizedBox(
              width: 25,
            ),
            Expanded(
                child: ElevatedButton(onPressed: () {}, child: Text("Delete")))
          ],
        )
      ],
    );
  }
}
