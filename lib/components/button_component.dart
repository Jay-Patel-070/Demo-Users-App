import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String buttontitle;
  final VoidCallback ontap;
  final bool? isloading;
  const ButtonComponent({super.key,required this.ontap,required this.buttontitle,this.isloading});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isloading ?? false,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primarycolor,
          padding: .symmetric(vertical:10),
          minimumSize: Size(double.infinity,0),
          shape: RoundedRectangleBorder(
            borderRadius: .circular(10)
          ),
          disabledBackgroundColor: AppColors.primarycolor
        ),
        onPressed: ontap,
        child: isloading == true ? Transform.scale(scale: 0.6,child: CircularProgressIndicator(color: AppColors.whitecolor,)) : Text(buttontitle,textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white,
          fontFamily: Appfonts.robotomedium,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),),
      ),
    );
  }
}
