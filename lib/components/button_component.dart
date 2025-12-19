import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String buttontitle;
  final VoidCallback ontap;
  final bool? isloading;
  final Color? bgcolor;
  final double? width;
  const ButtonComponent({super.key,required this.ontap,required this.buttontitle,this.isloading,this.bgcolor,this.width});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isloading ?? false,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor ?? AppColors.primarycolor,
          minimumSize: Size(width ?? double.infinity,45),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(AppRadius.md),
          ),
          disabledBackgroundColor: AppColors.primarycolor
        ),
        onPressed: ontap,
        child: isloading == true ? Transform.scale(scale: 0.6,child: Cm.showLoader(color: AppColors.whitecolor)) : Text(buttontitle,textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white,
          fontFamily: Appfonts.robotomedium,
          fontSize: AppFontSizes.xl,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }
}
