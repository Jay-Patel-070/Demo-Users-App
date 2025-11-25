import 'dart:convert';

import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/components/button_component.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/users/bloc/users_bloc.dart';
import 'package:demo_users_app/screens/users/bloc/users_event.dart';
import 'package:demo_users_app/screens/users/bloc/users_state.dart';
import 'package:demo_users_app/screens/users/data/user_datarepository.dart';
import 'package:demo_users_app/screens/users/data/user_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cm.dart';
import '../../components/textfield_component.dart';
import '../../utils/utils.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final UsersBloc usersBloc = UsersBloc(UserDatarepository(UserDatasource()));
  final _formkey = GlobalKey<FormState>();
  TextEditingController firstnamecontroller = TextEditingController(
    text: userData?.firstName,
  );
  TextEditingController lastnamecontroller = TextEditingController(
    text: userData?.lastName,
  );
  TextEditingController agecontroller = TextEditingController(
    text: userData?.age.toString(),
  );
  TextEditingController gendercontroller = TextEditingController(
    text: userData?.gender,
  );
  TextEditingController emailcontroller = TextEditingController(
    text: userData?.email,
  );
  FocusNode firstnamefocusnode = FocusNode();
  FocusNode lastnamefocusnode = FocusNode();
  FocusNode agefocusnode = FocusNode();
  FocusNode genderfocusnode = FocusNode();
  FocusNode emailfocusnode = FocusNode();

  @override
  void initState() {
    super.initState();
    firstnamefocusnode = FocusNode();
    lastnamefocusnode = FocusNode();
    agefocusnode = FocusNode();
    genderfocusnode = FocusNode();
    emailfocusnode = FocusNode();
  }

  @override
  void dispose() {
    firstnamefocusnode.dispose();
    lastnamefocusnode.dispose();
    agefocusnode.dispose();
    genderfocusnode.dispose();
    emailfocusnode.dispose();
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    agecontroller.dispose();
    gendercontroller.dispose();
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      bloc: usersBloc,
      listener: (context, state) {
        if (state.apicallstate == UsersApiCallState.success) {
          sharedprefshelper.saveData(LocalStorageKeys.userData, jsonEncode(state.userresponse?.toJson()));
          userData = state.userresponse;
          Navigator.pop(context);
        }
        if (state.apicallstate == UsersApiCallState.failure) {
          Cm.showSnackBar(context, message: state.error.toString());
        }
      },
      child: BlocBuilder<UsersBloc, UsersState>(
        bloc: usersBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 50),
              child: AppbarComponent(title: AppLabels.edit_profile, centertitle: true),
            ),
            body: Form(
              key: _formkey,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: AppPadding.lg),
                children: [
                  sb(20),
                  TextfieldComponent(
                    focusnode: firstnamefocusnode,
                    label: AppLabels.first_name,
                    controller: firstnamecontroller,
                    textinputtype: TextInputType.name,
                    validator: (value) {
                      return Cm.validate(value, AppLabels.first_name,firstnamefocusnode);
                    },
                  ),
                  sb(20),
                  TextfieldComponent(
                    focusnode: lastnamefocusnode,
                    label: AppLabels.last_name,
                    controller: lastnamecontroller,
                    textinputtype: TextInputType.name,
                    validator: (value) {
                      return Cm.validate(value, AppLabels.last_name,lastnamefocusnode);
                    },
                  ),
                  sb(20),
                  TextfieldComponent(
                    focusnode: agefocusnode,
                    label: AppLabels.age,
                    controller: agecontroller,
                    textinputtype: TextInputType.number,
                    validator: (value) {
                      return Cm.validate(value, AppLabels.age,agefocusnode);
                    },
                  ),
                  sb(20),
                  TextfieldComponent(
                    focusnode: genderfocusnode,
                    label: AppLabels.gender,
                    controller: gendercontroller,
                    textinputtype: TextInputType.name,
                    validator: (value) {
                      return Cm.validate(value, AppLabels.gender,genderfocusnode);
                    },
                  ),
                  sb(20),
                  TextfieldComponent(
                    focusnode: emailfocusnode,
                    label: AppLabels.email,
                    controller: emailcontroller,
                    textinputtype: TextInputType.emailAddress,
                    validator: (value) {
                      return Cm.validate(value, AppLabels.email,emailfocusnode);
                    },
                  ),
                  sb(200),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: EdgeInsets.only(left: AppPadding.lg, right: AppPadding.lg, bottom: AppPadding.lg),
              child: ButtonComponent(ontap: onTapSaveChanges, buttontitle: AppLabels.save_changes,isloading: state.apicallstate == UsersApiCallState.busy ? true : false,),
            ),
          );
        },
      ),
    );
  }

  onTapSaveChanges() {
    FocusScope.of(context).unfocus();
    Cm.focusGiven = false;
    if (_formkey.currentState?.validate() == true) {
      usersBloc.add(UpdateAuthUserEvent(params: {
        "firstName": firstnamecontroller.text.trim(),
        "lastName": lastnamecontroller.text.trim(),
        "age": agecontroller.text.trim(),
        "gender": gendercontroller.text.trim(),
        "email": emailcontroller.text.trim(),
      }, id: userData?.id));
    }
  }
}
