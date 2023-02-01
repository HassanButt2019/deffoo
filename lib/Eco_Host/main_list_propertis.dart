import 'package:deffo/Eco_Host/Create_property/Edit_Property/add_account.dart';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/edit_property_image.dart';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/general_edit.dart';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/list_of_room_type.dart';
import 'package:deffo/Eco_Host/Create_property/create_property.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class MainListProperties extends StatefulWidget {
  final propertyData;
  final checkEdit;
  final index;

  const MainListProperties({Key? key, this.propertyData, this.index, this.checkEdit}) : super(key: key);

  @override
  State<MainListProperties> createState() => _MainListPropertiesState();
}

class _MainListPropertiesState extends State<MainListProperties> {
  int _activeCurrentStep = 0;
  bool shouldPop = false;

  showExit()async{
    showDialog(context: context, builder: (context){
      return AlertDialog(
      title: Text("Are you Sure ?"),
        content: Text("Ensure you have saved your data successfully. or you can come again later for edit"),
        actions: [
          TextButton(onPressed: (){
            setState(() {
              shouldPop = true;
            });
            Navigator.pop(context , true);
            Navigator.pop(context , true);
          }, child: Text("Exit")),
          TextButton(onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          }, child: Text("Cancel")),
        ],
      );
    });
  }


  List<Step> stepList() => [
        Step(
            title: FittedBox(
              child: Text(
                'Property',
                style: TextStyle(fontSize: 10),
              ),
            ),
            content: CreatePropertyPage(
              propertiesDetails:widget.checkEdit?widget.propertyData:null,
              checkEdit: widget.checkEdit,
            )),
        Step(
            title: Text(
              'General',
              //
              style: TextStyle(fontSize: 10),
            ),
            content: GeneralEditPage(
              propertiesDetails:
                  widget.propertyData != null ? widget.propertyData : null,
              selected: true,
              checkEdit: widget.checkEdit,
            )),
        Step(
        title: FittedBox(
          child: Text(
            'Banners',
            style: TextStyle(fontSize: 10),
          ),
        ),
        content: PropertyImages(
            propertyId: widget.propertyData,
          checkEdit: widget.checkEdit,
        )),
        Step(
            title: Text(
              "Room",
              style: TextStyle(fontSize: 10),
            ),
            content: ListOfRoomTypePage(
           propertyData:  widget.propertyData != null ? widget.propertyData : null,
              index: _activeCurrentStep,
              checkEdit: widget.checkEdit,
            )),
        /*Step(
            title: Text(
              'Account',
              style: TextStyle(fontSize: 10),
            ),
            content: PropertyAccountDetails(
              accountData: widget.propertyData!=null?widget.propertyData:null,
              checkEdit: widget.checkEdit,

            )),*/
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activeCurrentStep = widget.index??0;
  }
  Future<bool> back()async{
    Navigator.pop(context,"yes");
    return Future.value();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: back,
      child: KeyboardDismisser(
        gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
        child: Scaffold(
          body: SafeArea(
            child: Stepper(
              type: StepperType.horizontal,
              controlsBuilder: (BuildContext context, ControlsDetails details){
                return SizedBox();
              },
              steps: stepList(),
              currentStep: _activeCurrentStep,

              // onStepContinue takes us to the next step
              onStepContinue: () {
                if (_activeCurrentStep < (stepList().length - 1)) {
                  setState(() {
                    _activeCurrentStep += 1;
                  });
                }

              },
              // new
              onStepCancel: () {
                if (_activeCurrentStep == 0) {
                  return;
                }

                setState(() {
                  _activeCurrentStep -= 1;
                });
              },
              // new
              onStepTapped: (int index) {
                setState(() {
                  if(widget.checkEdit){
                      _activeCurrentStep = index;
                  }else{
                    UtilityHlepar.getToast("Work while editing");
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
