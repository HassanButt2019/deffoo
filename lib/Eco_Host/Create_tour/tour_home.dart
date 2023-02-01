import 'package:deffo/Eco_Host/Create_tour/tour_parts/tour_account.dart';
import 'package:deffo/Eco_Host/Create_tour/tour_parts/tour_details.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';


class TourHome extends StatefulWidget {
  final index;
  final edit;
  final tourData;
  const TourHome({Key? key, this.index, this.tourData, this.edit}) : super(key: key);

  @override
  _TourHomeState createState() => _TourHomeState();
}

class _TourHomeState extends State<TourHome> {
  var _currentSteps = 0;

  List<Step> stepList() => [
    Step(
        title: FittedBox(
          child: Text(
            'Property',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: TourDetails(edit: widget.edit, tourData: widget.tourData)),
    // Step(
    //     title: FittedBox(
    //       child: Text(
    //         'Account',
    //         style: TextStyle(fontSize: 10),
    //       ),
    //     ),
    //     content: TourAccount(edit: widget.edit, tourData: widget.tourData,)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentSteps = widget.index??0;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: KeyboardDismisser(
        gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
        child: Scaffold(
          body: Stepper(
              controlsBuilder: (BuildContext context, ControlsDetails details){
                return SizedBox();
              },
              currentStep: _currentSteps,
              onStepTapped: (index){
                setState(() {
                  _currentSteps = index;
                });
              },
              steps: stepList() , type: StepperType.horizontal),
        ),
      ),
    );
  }
}
