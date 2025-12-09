import 'dart:convert';
import 'dart:io';
import 'package:demo_users_app/extension.dart';
import 'package:demo_users_app/helper/shared_preference_helper.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/users/model/user_response.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget sb(double height) {
  return SizedBox(height: height);
}

Widget sbw(double width) {
  return SizedBox(width: width);
}

getUserData() {
  final userlocaldata = sharedprefshelper.getData(LocalStorageKeys.userData);
  if (userlocaldata != null) {
    final userData = UserResponse.fromJson(jsonDecode(userlocaldata));
    return userData;
  }
  return null;
}

Future<String> getAccessToken() async{
  return await sharedprefshelper.getData(LocalStorageKeys.accessToken) ?? "";
}

Future<String> getRefreshToken() async{
  return await sharedprefshelper.getData(LocalStorageKeys.refreshToken) ?? "";
}

void callNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));
}

Future callNextScreenWithResult(BuildContext context, Widget nextScreen) async {
  var action = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );

  return action;
}

void callNextScreenAndClearStack(BuildContext context, Widget nextScreen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
    (Route<dynamic> route) => false,
  );
}

class Cm {
  static bool focusGiven = false;
  static String? validate(
    String? value,
    String fieldname,
    FocusNode focusnode,
  ) {
    if (focusGiven == false && value == null) {
      // Will reset before every validate() call
      focusGiven = false;
    }
    if (value == null || value.isEmpty) {
      if (!focusGiven) {
        focusnode.requestFocus();
        focusGiven = true;
      }
      return 'please enter $fieldname';
    }
    if (fieldname == AppLabels.password) {
      if (value.length < 3) {
        if (!focusGiven) {
          focusnode.requestFocus();
          focusGiven = true;
        }
        return 'Please enter a valid Password';
      }
    }
    if (fieldname == AppLabels.age) {
      if (value.length > 3) {
        if (!focusGiven) {
          focusnode.requestFocus();
          focusGiven = true;
        }
        return 'Please enter a valid Age';
      }
    }
    if (fieldname == AppLabels.email) {
      if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
        if (!focusGiven) {
          focusnode.requestFocus();
          focusGiven = true;
        }
        return 'Please enter a valid email address';
      }
    }
    return null;
  }

  static Widget showLoader() {
    return CircularProgressIndicator(color: AppColors.primarycolor,);
  }

  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? bg,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Appfonts.robotobold,
              fontSize: AppFontSizes.xl,
            ),
          ),
          backgroundColor: bg,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: .circular(AppRadius.md)),
          // margin: const EdgeInsets.only(top: , left: 10, right: 10),
          dismissDirection: DismissDirection.up,
          duration: Duration(seconds: 2),
        ),
      );
  }

  static Future<File?> pickImage(ImageSource source, ImagePicker picker) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      return imageFile;
    } else {
      return null;
    }
  }
}
