import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_part/track_and_trails_account.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_part/track_and_trails_days.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_part/track_and_trails_details.dart';
import 'package:deffo/Eco_Host/Create_track_and_trails/track_trails_part/track_and_trails_general.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class TrackAndTrailsPage extends StatefulWidget {
  final index;
  final edit;
  final trackData;
  const TrackAndTrailsPage({Key? key, this.index, this.edit, this.trackData}) : super(key: key);

  @override
  _TrackAndTrailsPageState createState() => _TrackAndTrailsPageState();
}

class _TrackAndTrailsPageState extends State<TrackAndTrailsPage> {
  var _currentStep = 0;


  List<Step> stepList() => [
    Step(
        title: FittedBox(
          child: Text(
            'Property',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: TrackAndTrailsDetails(edit: widget.edit, trackData: widget.trackData,)),
    Step(
        title: FittedBox(
          child: Text(
            'General',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: TrackAndTrailsGeneral(edit: widget.edit, trackData: widget.trackData,)),
    Step(
        title: FittedBox(
          child: Text(
            'Days',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: TrackAndTrailsDays(edit: widget.edit, trackData: widget.trackData,)),
    // Step(
    //     title: FittedBox(
    //       child: Text(
    //         'Account',
    //         style: TextStyle(fontSize: 10),
    //       ),
    //     ),
    //     content: TrackAndTrailsAccount(edit: widget.edit, trackData:  widget.trackData,)),
  ];

  Future<bool> back()async{
    Navigator.pop(context,"yes");
    return Future.value();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentStep = widget.index??0;
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
              currentStep: _currentStep,
              type: StepperType.horizontal,
              controlsBuilder: (BuildContext context, ControlsDetails details){
                return SizedBox();
              },
              onStepTapped: (index){
                if(widget.edit){
                  setState(() {
                    _currentStep = index;
                  });
                }else{
                  UtilityHlepar.getToast("Work During Edit");
                }

              },
              steps: stepList(),),
          ),
        ),
      ),
    );
  }
}
