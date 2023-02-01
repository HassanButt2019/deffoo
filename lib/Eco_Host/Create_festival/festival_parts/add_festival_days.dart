import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/AddFestivalDaysModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddFestivalDays extends StatefulWidget {
  final edit;
  final fesData;
  const AddFestivalDays({Key? key, this.edit, this.fesData}) : super(key: key);

  @override
  _AddFestivalDaysState createState() => _AddFestivalDaysState();
}

class _AddFestivalDaysState extends State<AddFestivalDays> {
  var dropdownValue;

  var desController = TextEditingController();


  _addFestivalDays()async{
    try{
     AddFestivalDaysModel? model = await addFestivalDays(widget.fesData.id, desController.text);
     if(model!.status == true){
       UtilityHlepar.getToast(model.meassge);
       Navigator.pop(context , true);
     }else{
       UtilityHlepar.getToast(model.meassge);
     }
    }catch(e){
      UtilityHlepar.getToast("Something Went Wrong");
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: height / 120),
                  child: Text(
                    "Day-wise Details\nDay",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppTheme.purple),
                  ),
                ),
                TextField(
                  controller: desController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ],
            ),
            Row(children: [
              Expanded(child: ElevatedButton(onPressed: (){
                _addFestivalDays();
              }, child: Text("Save"))),
              SizedBox(width: 25,),
              Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Delete"))),
            ],)
          ],
        ),
      ),
    );
  }
}
