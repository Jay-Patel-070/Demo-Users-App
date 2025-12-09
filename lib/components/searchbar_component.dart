import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchbarComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final bool? readOnly;

  const SearchbarComponent({
    super.key,
    required this.controller,
    this.hintText = AppStrings.Search,
    this.onChanged,
    this.onClear,
    this.focusNode,
    this.readOnly
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: .circular(AppRadius.lg),
                borderSide: BorderSide.none
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                color: AppColors.greywithshade,
                fontFamily: Appfonts.roboto,
                fontSize: AppFontSizes.lg,
              ),
              prefixIcon: Icon(Icons.search, color: AppColors.greywithshade,fontWeight: FontWeight.w500,),
              suffixIcon:  value.text.isNotEmpty ? IconButton(onPressed: onClear, icon: Icon(Icons.close, color: AppColors.greywithshade,fontWeight: FontWeight.w500) ) : null
          ),
          cursorColor: AppColors.primarycolor,
          // readOnly: readOnly ?? false,
          // autofocus: true,
        );
      },
    );
  }
}
