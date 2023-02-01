import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/CreateCycleBrandsModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddCyclingBrands extends StatefulWidget {
  final cycleData;

  const AddCyclingBrands({Key? key, this.cycleData}) : super(key: key);

  @override
  _AddCyclingBrandsState createState() => _AddCyclingBrandsState();
}

class _AddCyclingBrandsState extends State<AddCyclingBrands> {
  var dropdownValue;

  var noOfBikes = 1;

  var brandController = TextEditingController();

  var rateController = TextEditingController();

  var otherDetailsController = TextEditingController();

  _createCycleBrands() async {
    try {
      var cId = widget.cycleData.id;
      var brandName = "${brandController.text}";
      var newNoOfBikes = "$noOfBikes";
      var rate = "${rateController.text}";
      var type = "$dropdownValue";
      var details = "${otherDetailsController.text}";
      CreateCycleBrandsModel? model = await createCycleBrands(
          cId, brandName, newNoOfBikes, rate, type, details);
      if (model!.status == true) {
        Navigator.pop(context, true);
        UtilityHlepar.getToast(model.meassge);
      } else {
        UtilityHlepar.getToast(model.meassge);
      }
    } catch (e) {
      print(e);
      UtilityHlepar.getToast("Something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            DeffoTextField(
              controller: brandController,
              hint: "Brand Name",
            ),
            Row(
              children: [
                Text("Number of Bikes you will\noffer under this brands"),
                SizedBox(width: 5,),
                FloatingActionButton(
                  mini: true,
                    onPressed: () {
                      if (noOfBikes > 1) {
                        setState(() {
                          noOfBikes--;
                        });
                      } else {
                        UtilityHlepar.getToast("limit");
                      }
                    },
                    child: Icon(Icons.remove)),
                SizedBox(width: 5,),
                Text("$noOfBikes"),
                SizedBox(width: 5,),
                FloatingActionButton(
                  mini: true,
                    onPressed: () {
                      setState(() {
                        noOfBikes++;
                      });
                    },
                    child: Icon(Icons.add)),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: DeffoTextField(
                  controller: rateController,
                  keyboard: TextInputType.number,
                  hint: "Rate",
                )),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>[
                      'per trip',
                      'per hour',
                      'per day',
                      'per week',
                      "per month"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: height / 120),
                  child: Text(
                    "Other Details If any",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.purple),
                  ),
                ),
                TextField(
                  controller: otherDetailsController,
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
                          _createCycleBrands();
                        },
                        child: Text("Save"))),
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {}, child: Text("Delete"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
