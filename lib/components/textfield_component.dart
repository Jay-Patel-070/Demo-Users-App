import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class TextfieldComponent extends StatelessWidget {
  final VoidCallback? ontap;
  final VoidCallback? suffixicontap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String hinttext;
  final String? label;
  final Icon? prefixicon;
  IconData? suffixicon;
  final bool? obsecuretext;
  final bool? showprefixicon;
  final TextInputType textinputtype;
  final FocusNode? focusnode;
  TextfieldComponent({
    this.ontap,
    this.controller,
    this.validator,
    required this.hinttext,
    this.prefixicon,
    this.obsecuretext,
    this.suffixicon,
    this.showprefixicon,
    this.suffixicontap,
    this.label,
    this.textinputtype = TextInputType.name,
    this.focusnode
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          label ?? '',
          style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          focusNode: focusnode,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixicon,
            hintText: hinttext,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondarycolor),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondarycolor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primarycolor),
            ),
            suffixIcon: IconButton(
              onPressed: suffixicontap,
              icon: Icon(suffixicon,color: AppColors.blackcolor,),
            ),
          ),
          obscureText: obsecuretext ?? false,
          onTap: ontap,
          cursorColor: AppColors.primarycolor,
          keyboardType: textinputtype,
          validator: validator,
        ),
      ],
    );
  }
}