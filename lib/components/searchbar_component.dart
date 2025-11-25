import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchbarComponent extends StatelessWidget {
  final TextEditingController controller;
  final Color? backgroundcolor;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final bool? showborder;
  final VoidCallback? onClear;
  final FocusNode? focusNode;

  const SearchbarComponent({
    super.key,
    required this.controller,
    this.showborder = true,
    this.backgroundcolor = AppColors.whitecolor,
    this.hintText = AppStrings.Search,
    this.onChanged,
    this.onClear,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundcolor,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: showborder==true ? Border.all(
          width: 0.4,
          color: AppColors.secondarycolor
        ) : null
      ),
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, value, child) {
          return TextField(
            focusNode: focusNode,
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.greycolor,
                  fontFamily: Appfonts.roboto,
                  fontSize: AppFontSizes.xl,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.greywithshade,fontWeight: FontWeight.w500,),
                suffixIcon:  value.text.isNotEmpty ? IconButton(onPressed: onClear, icon: Icon(Icons.close, color: AppColors.greywithshade,fontWeight: FontWeight.w500) ) : null
            ),
          );
        },
      ),
    );
  }
}
