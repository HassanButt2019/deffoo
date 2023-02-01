import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/CreateTrackAccountsModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CyclingAccount extends StatefulWidget {
  final edit;
  final cycleData;

  const CyclingAccount({Key? key, this.edit, this.cycleData}) : super(key: key);

  @override
  _CyclingAccountState createState() => _CyclingAccountState();
}

class _CyclingAccountState extends State<CyclingAccount> {
  var accountNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var confirmAccountController = TextEditingController();
  var ifscController = TextEditingController();

  late String _selection;

  late List<String> selectbank = <String>[
    'State Bank of India',
    'Bank of India',
    'HDFC Bank',
    'ICICI Bank'
  ];

  _createCycleAccount() async {
    try{var cycleId = "${widget.edit}";
    var accountName = "${accountNameController.text}";
    var accountNo = "${accountNumberController.text}";
    var bankName = "$_selection";
    var ifscCode = "${ifscController.text}";
    CreateTrackAccountsModel? model = await createCycleAccount(
        cycleId, accountName, accountNo, bankName, ifscCode);
    if(model!.status == true){
      UtilityHlepar.getToast("${model.status}");
      UtilityHlepar.getToast("You Can Exit Now");
    }else{
      UtilityHlepar.getToast("${model.status}");
    }}catch(e){
      UtilityHlepar.getToast("Something went wrong");
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selection = selectbank[0];
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        DeffoTextField(
          controller: accountNameController,
          hint: "Account Name",
        ),
        DeffoTextField(
          controller: accountNumberController,
          hint: "Account Number",
        ),
        DeffoTextField(
          controller: confirmAccountController,
          hint: "Confirm Account Number",
        ),
        // DeffoTextField(
        //   hint: "Select bank",
        // ),
        Container(
          margin: EdgeInsets.symmetric(vertical: mysize.height / 60),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(width: 1.0, color: Colors.grey)),
          width: mysize.width,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text('Select Bank'),
              items: selectbank.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: _selection,
              onChanged: (value) {
                print(value);
                setState(() {
                  _selection = value!;
                });
              },
            ),
          ),
        ),

        DeffoTextField(
          controller: ifscController,
          hint: "Search IFSC code",
        ),
        SizedBox(
          height: 10,
        ),
        Row(children: [
          Expanded(child: ElevatedButton(
            onPressed: (){_createCycleAccount();},
            child: Text("Save"),
          )),
          SizedBox(width: 25,),
          Expanded(child: ElevatedButton(
            onPressed: (){},
            child: Text("Delete"),
          ))
        ],)
      ],
    );
  }
}
