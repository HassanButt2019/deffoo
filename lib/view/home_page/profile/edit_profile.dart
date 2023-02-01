import 'dart:io';

import 'package:deffo/api/api_path.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:deffo/model/response/UpdateProfileResponse.dart';
import 'package:deffo/model/response/get_profile_response.dart';
import 'package:deffo/token/app_token_data.dart';
import 'package:deffo/utility/utility_hlepar.dart';
import 'package:deffo/validation/form_validation.dart';
import 'package:deffo/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  GetProfileResponse? getProfileResponse;
  String type;
  EditProfilePage(this.type,{Key? key, this.getProfileResponse}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  final ImagePicker picker = ImagePicker();
  var imgFile;

  _updateProfile(image, {from}) async {
    try {
      String userid = await MyToken.getUserID();
      UpdateProfileResponse? response = await updateProfile(
          userid, nameController.text, emailController.text, image,url: widget.type=="User"?"":"yes");
      if (response!.status == true) {
        UtilityHlepar.getToast("updated profile successfully");
        Navigator.pop(context);
      } else {
        UtilityHlepar.getToast("updated profile successfully");
      }
    } catch (e) {
      UtilityHlepar.getToast("updated profile successfully");
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    editController();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: DeffoAppBar(
          title: "Edit Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: AnimationLimiter(
          child: Form(
            key: formKey,
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 375),
                  childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                  children: [
                    SizedBox(
                      height: height * .02,
                    ),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          onTap: () => showOptionsDialog(context),
                          child: Material(
                              borderRadius: BorderRadius.circular(60),
                              elevation: 10,
                              child: imgFile != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60),
                                      child: Image.file(
                                        imgFile,
                                        height: 120,
                                        width: 120,
                                        scale: 1,
                                        fit: BoxFit.cover,
                                      ))
                                  : widget.getProfileResponse!=null?CircleAvatar(
                                      backgroundImage: NetworkImage(widget
                                              .getProfileResponse!.imgPath
                                              .toString() +
                                          widget.getProfileResponse!.profile![0]
                                              .userImage
                                              .toString()),
                                      radius: 60,
                                    ):Icon(Icons.person,size: 120,color: Colors.grey,),),
                        ),
                        // displayImage(),
                        Material(
                          borderRadius: BorderRadius.circular(60),
                          elevation: 10,
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 15,
                              child: Icon(
                                Icons.edit_sharp,
                                size: 18,
                                color: Color(0xffFFC736),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    // Text("Johan Deo"),
                    CustomTextField(
                      controller: nameController,
                      label: "User Name",
                      validator: FormValidation.checkEmptyValidator,
                    ),
                    CustomTextField(
                      controller: emailController,
                      label: "Email",
                      validator: FormValidation.emailVeledetion,
                    ),
                    CustomTextField(
                      readOnly: true,
                      controller: phoneController,
                      label: "Phone Number",
                      validator: FormValidation.validateMobile,
                    ),
                    SizedBox(
                      height: height * .02,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          _updateProfile(imgFile, from: 1);
                        }
                      },
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.only(bottom: 38),
                        child: Container(
                          height: 58,
                          width: width * .8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Color(0xff552279),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

// Form Filed Value
  editController() async {
    await App.init();
    if(widget.getProfileResponse!=null){
      nameController.text =
          widget.getProfileResponse!.profile![0].firstname ?? "";
      emailController.text =
          widget.getProfileResponse!.profile![0].userEmail ?? "";
      phoneController.text =
          widget.getProfileResponse!.profile![0].userPhone ?? "";
    }else{
      nameController.text = App.localStorage.getString("name").toString();
      emailController.text = App.localStorage.getString("email").toString();
      phoneController.text = App.localStorage.getString("phone").toString();
    }

    setState(() {});
  }

  File? imgFileNew;
  final imgPicker = ImagePicker();

  void openCamera() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();

  }

  openGallery() async {
    var imgCamera = await imgPicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imgFile = File(imgCamera!.path);
    });
    Navigator.of(context).pop();
  }

  Widget displayImage() {
    if (imgFile == null) {
      return Text("No Image Selected!");
    } else {
      return Image.file(imgFile, width: 350, height: 350);
    }
  }

  Future<void> showOptionsDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Options"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text("Take Image From Camera"),
                    onTap: () {
                      openCamera();
                    },
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text("Take Image From Gallery"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class CustomTextField extends StatelessWidget {
  final label;
  final controller;
  final validator;
  final readOnly;

  const CustomTextField(
      {Key? key, this.label, this.controller, this.validator, this.readOnly})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextFormField(
        readOnly: readOnly ?? false,
        controller: controller,
        validator: validator ?? null,
        decoration: InputDecoration(label: Text(label)),
      ),
    );
  }
}
