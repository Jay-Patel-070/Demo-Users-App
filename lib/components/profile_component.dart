import 'dart:io';

import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileComponent extends StatelessWidget {
  final String? imagepath;
  final VoidCallback? ontap;
  final bool? showeditbutton;
  const ProfileComponent({
    super.key,
    this.imagepath,
    this.ontap,
    this.showeditbutton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: ontap,
        child: Stack(
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: .circular(AppRadius.circle),
                  image: DecorationImage(image: imagepath == null ? AssetImage(
                    'assets/images/profile.png',
                  ) : FileImage(File(imagepath ?? '')
                  ),
                  fit: BoxFit.cover
                  ),
                )
              ),
              showeditbutton == true ? Positioned(bottom: 12,right: 10,child: CircleAvatar(radius: 15,backgroundColor:AppColors.greencolor,child:  Icon(imagepath == null ? Icons.add : Icons.edit,color: AppColors.whitecolor))) : SizedBox.shrink()
            ]
        ),
      ),
    );
  }
}
