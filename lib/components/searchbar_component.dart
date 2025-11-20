import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchbarComponent extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const SearchbarComponent({
    super.key,
    required this.controller,
    this.hintText = AppStrings.Search,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.whitecolor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.4,
          color: AppColors.secondarycolor
        )
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: AppColors.greywithshade,fontWeight: FontWeight.w500,),
          sbw(30),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.greycolor,
                  fontFamily: Appfonts.roboto,
                  fontSize: 18
                )
              ),
            ),
          ),
          if (controller.text.isNotEmpty)
            GestureDetector(
              onTap: onClear,
              child: Icon(Icons.close, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
