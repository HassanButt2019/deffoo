import 'package:deffo/Eco_Host/Create_festival/festival_home.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateFestivalThingsModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';

class FestivalItems extends StatefulWidget {
  final edit;
  final fesData;

  const FestivalItems({Key? key, this.edit, this.fesData}) : super(key: key);

  @override
  _FestivalItemsState createState() => _FestivalItemsState();
}

class _FestivalItemsState extends State<FestivalItems> {
  var itemController = TextEditingController();

  _createItem() async {
    try {
      var fesId = "${widget.fesData.id}";
      var things = "${itemController.text}";
      CreateFestivalThingsModel? model =
          await createFestivalThings(fesId, things);
      if (model!.status == true) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FestivalHome(
                      index: 2,
                      edit: widget.edit,
                      fesData: widget.fesData,
                    )));
      } else {
        UtilityHlepar.getToast(model.meassge);
      }
    } catch (e) {
      print(e);
      UtilityHlepar.getToast("something went Wrong");
    }
  }

  _update(){
    var data = widget.fesData;
    itemController.text = data.thingsCarry;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.edit?_update():print("New");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height / 120),
          child: Text(
            "Things to carry during the festivals",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.purple),
          ),
        ),
        TextField(
          controller: itemController,
          maxLines: 5,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
        ),
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _createItem();
                    },
                    child: Text("Save"))),
            SizedBox(
              width: 25,
            ),
            Expanded(
                child: ElevatedButton(onPressed: () {}, child: Text("Delete"))),
          ],
        )
      ],
    );
  }
}
