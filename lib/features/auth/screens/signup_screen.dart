import 'dart:io';

import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/components/profile_component.dart';
import 'package:demo_users_app/components/textfield_component.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../cm.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool ismale = true;
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final ImagePicker imagepicker = ImagePicker();
  File? file;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whitecolor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppbarComponent(
          title: AppStrings.create_your_account,
          centertitle: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              ProfileComponent(showeditbutton: true,
              imagepath: file?.path,
              ontap: () => ontapProfileComponent(),
              ),
              sb(20),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextfieldComponent(
                      hinttext: AppStrings.john,
                      label: AppLabels.first_name,
                      controller: firstnamecontroller,
                      validator: (value) {
                        // return Cm.validate(value, AppLabels.first_name);
                      },
                    ),
                  ),
                  sbw(10),
                  Expanded(
                    flex: 1,
                    child: TextfieldComponent(
                      hinttext: AppLabels.last_name,
                      label: AppLabels.last_name,
                      controller: lastnamecontroller,
                      validator: (value) {
                        // return Cm.validate(value, AppLabels.last_name);
                      },
                    ),
                  ),
                ],
              ),
              sb(20),
              TextfieldComponent(
                hinttext: AppStrings.exampleage,
                label: AppLabels.age,
                controller: agecontroller,
                textinputtype: TextInputType.number,
                validator: (value) {
                  // return Cm.validate(value, AppLabels.age);
                },
              ),
              sb(20),
              Text(
                AppLabels.gender,
                style: TextStyle(fontFamily: Appfonts.roboto, fontSize: 18),
              ),
              sb(10),
              Container(
                width: double.infinity,
                padding: .all(10),
                decoration: BoxDecoration(
                  borderRadius: .circular(10),
                  color: AppColors.secondarycolor.withOpacity(0.2),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    togglegenderwidget(
                      ontap: () {
                        setState(() {
                          ismale = true;
                        });
                      },
                      label: AppLabels.male,
                      color: ismale
                          ? AppColors.whitecolor
                          : AppColors.whitecolor.withOpacity(0),
                      labelcolor: ismale
                          ? AppColors.blackcolor
                          : AppColors.greycolor,
                    ),
                    sbw(10),
                    togglegenderwidget(
                      ontap: () {
                        setState(() {
                          ismale = false;
                        });
                      },
                      label: AppLabels.female,
                      color: ismale
                          ? AppColors.whitecolor.withOpacity(0)
                          : AppColors.whitecolor,
                      labelcolor: ismale
                          ? AppColors.greycolor
                          : AppColors.blackcolor,
                    ),
                  ],
                ),
              ),
              sb(20),
              TextfieldComponent(
                hinttext: AppStrings.exampleemail,
                label: AppLabels.email,
                controller: emailcontroller,
                validator: (value) {
                  // return Cm.validate(value, AppLabels.email);
                },
              ),
              sb(20),
              TextfieldComponent(
                hinttext: AppStrings.enter_a_strong_password,
                label: AppLabels.password,
                controller: passwordcontroller,
                validator: (value) {
                  // return Cm.validate(value, AppLabels.password);
                },
              ),
              sb(30),
              ButtonComponent(
                ontap: () {
                  if (_formkey.currentState?.validate() == true) {
                    print('clicked');
                  }
                },
                buttontitle: AppLabels.create_account,
              ),
              sb(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.already_have_an_account),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLabels.login,
                      style: TextStyle(
                        color: AppColors.primarycolor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primarycolor,
                        fontFamily: Appfonts.robotobold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget togglegenderwidget({
    required VoidCallback ontap,
    required String label,
    required Color labelcolor,
    required Color color,
  }) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: ontap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Appfonts.robotomedium,
              fontSize: 18,
              color: labelcolor,
            ),
          ),
          padding: .symmetric(vertical: 10),
          decoration: BoxDecoration(borderRadius: .circular(10), color: color),
        ),
      ),
    );
  }

  ontapProfileComponent () async{
    file = await Cm.pickImage(ImageSource.gallery, imagepicker);
    setState(() {
    });
  }
}
