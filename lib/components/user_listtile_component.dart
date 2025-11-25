import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class UserListtileComponent extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final VoidCallback? ontap;
  bool? showicon;
  UserListtileComponent({super.key,this.ontap,required this.email,required this.name,required this.image,this.showicon = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: ontap,
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.whitecolor,
        backgroundImage: NetworkImage(image),
      ),
      title: Text(name,
      style: TextStyle(
        fontFamily: Appfonts.robotomedium,
        fontSize: AppFontSizes.xl,
      ),
      ),
      subtitle: Text(email,style: TextStyle(
          fontFamily: Appfonts.roboto,
          fontSize: AppFontSizes.lg,
        color: AppColors.greywithshade
      ),),
      trailing: showicon == true ? Icon(Icons.keyboard_arrow_right_outlined,
      color: AppColors.greywithshade,
      ) : SizedBox.shrink()
    );
  }
}
