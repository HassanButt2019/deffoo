import 'dart:io';

import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/app_theme.dart';
import 'package:deffo/model/AddAccountModel.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PropertyAccountDetails extends StatefulWidget {
  final accountData;
  final checkEdit;

  PropertyAccountDetails({Key? key, this.accountData, this.checkEdit}) : super(key: key);

  @override
  State<PropertyAccountDetails> createState() => _PropertyAccountDetailsState();
}

class _PropertyAccountDetailsState extends State<PropertyAccountDetails> {
  late List<String> selectbank = <String>[
    'State Bank of India',
    'Bank of India',
    'HDFC Bank',
    'ICICI Bank'
  ];
  late String _selection;

  var accountNameController = TextEditingController();
  var accountNumberController = TextEditingController();
  var confirmAccountController = TextEditingController();
  var ifscController = TextEditingController();

  File? finalImage;

  getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      cropImage(image.path);
    } else {
      UtilityHlepar.getToast("Cancel");
    }
  }

  cropImage(image) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: image,
        aspectRatioPresets: [
          // CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Deffo',
            toolbarColor: Colors.purple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      setState(() {
        finalImage = croppedFile;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _selection = selectbank[0];
if(widget.checkEdit){
  accountNameController.text = widget.accountData.accountName;
  accountNumberController.text = widget.accountData.accountNumber;
  confirmAccountController.text = widget.accountData.accountNumber;
  ifscController.text = widget.accountData.ifscCode;
}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mysize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: mysize.width / 120),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: mysize.height / 80),
                    child: Text(
                      'Your Account Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: AppTheme.purple),
                    ),
                  ),
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
                 widget.checkEdit?Text("Documents Already Sumitted"):
                  InkWell(
                    child: Container(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 1.0, color: Colors.grey)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Text(
                                'Upload cancelled cheque/ bank statement',
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  var id = "${widget.accountData.id}";
                                  var accountName = "${accountNameController.text}";
                                  var accountNo = "${accountNumberController.text}";
                                  var bankName = "$_selection";
                                  var ifsc = "${ifscController.text}";
                                  var image =finalImage!=null?finalImage!.path: "true";

                                  AddAccountModel? model = await addAccount(
                                      id,
                                      accountName,
                                      accountNo,
                                      bankName,
                                      ifsc,
                                      image);
                                  if(model!.status == true){
                                    UtilityHlepar.getToast("Account Added");
                                  }

                                } catch (e) {}
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Save"),
                                ],
                              )),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Delete"),
                                ],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              // Text("Rate",
              //     style: TextStyle(
              //         color: AppTheme.purple,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18)),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
              //   child: Column(
              //     children: [
              //       DeffoTextField(
              //         hint: "Price per Room/Per property",
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
