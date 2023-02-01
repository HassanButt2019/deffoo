import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_account.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_brands_list.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_details.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_parts/festival_account.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_parts/festival_details.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_parts/festival_days.dart';
import 'package:deffo/Eco_Host/Create_festival/festival_parts/festival_items.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';


class FestivalHome extends StatefulWidget {
  final edit;
  final fesData;
  final index;
  const FestivalHome({Key? key, this.edit, this.fesData, this.index}) : super(key: key);

  @override
  _FestivalHomeState createState() => _FestivalHomeState();
}

class _FestivalHomeState extends State<FestivalHome> {
  var _currentStep = 0;


  List<Step> stepList() => [
    Step(
        title: FittedBox(
          child: Text(
            'Property',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: FestivalDetails(edit: widget.edit , fesData: widget.fesData)),
    Step(
        title: FittedBox(
          child: Text(
            'General',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: FestivalItems(edit: widget.edit, fesData: widget.fesData,)),
    Step(
        title: FittedBox(
          child: Text(
            'Days',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: FestivalDays(edit:  widget.edit, fesData: widget.fesData,)),
    // Step(
    //     title: FittedBox(
    //       child: Text(
    //         'Account',
    //         style: TextStyle(fontSize: 10),
    //       ),
    //     ),
    //     content: FestivalAccounts(edit: widget.edit, fesData: widget.fesData,)),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentStep = widget.index??0;
  }

  Future<bool> back()async{
    Navigator.pop(context,"yes");
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: back,
        child: KeyboardDismisser(
          gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
          child: Scaffold(
          body: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details){
              return SizedBox();
            },
            onStepTapped: (index){
              if(widget.edit){
                setState(() {
                  _currentStep = index;
                });
              }else{
                UtilityHlepar.getToast("Work during Edit");
              }
            },
            currentStep: _currentStep,
            steps: stepList(),type: StepperType.horizontal,),
          ),
        ),
      ),
    );
  }
}
