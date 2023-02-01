import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_account.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_brands_list.dart';
import 'package:deffo/Eco_Host/Create_Cycling/cycling_parts/cycling_details.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CyclingHome extends StatefulWidget {
  final edit;
  final index;
  final cycleData;

  const CyclingHome({Key? key, @required this.edit, this.index, this.cycleData}) : super(key: key);

  @override
  _CyclingHomeState createState() => _CyclingHomeState();
}

class _CyclingHomeState extends State<CyclingHome> {
  var _currentStep = 0;




  List<Step> stepList() => [
        Step(
            title: FittedBox(
              child: Text(
                'Property',
                style: TextStyle(fontSize: 10),
              ),
            ),
            content: CyclingDetails(edit: widget.edit, cycleData: widget.cycleData,)),
        Step(
            title: FittedBox(
              child: Text(
                'General',
                style: TextStyle(fontSize: 10),
              ),
            ),
            content: BikeBrandsList(edit: widget.edit, cycleData: widget.cycleData,)),
        // Step(
        //     title: FittedBox(
        //       child: Text(
        //         'Account',
        //         style: TextStyle(fontSize: 10),
        //       ),
        //     ),
        //     content: CyclingAccount(edit: widget.edit, cycleData: widget.cycleData,)),
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
              onStepTapped: (index) {
                if (widget.edit) {
                  setState(() {
                    _currentStep = index;
                  });
                } else {
                  UtilityHlepar.getToast("Work During Edit");
                }
              },
              controlsBuilder: (BuildContext context, ControlsDetails details){
                return SizedBox();
              },
              currentStep: _currentStep,
              steps: stepList(),
              type: StepperType.horizontal,
            ),
          ),
        ),
      ),
    );
  }
}
