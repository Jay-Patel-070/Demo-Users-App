import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/features/auth/model/login_response_model.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppbarComponent(
          centertitle: true,
          title: AppLabels.user_details,
          actions: [
            TextButton(onPressed: () {

            }, child: Text(AppLabels.edit,style: TextStyle(color: AppColors.primarycolor,fontSize: 20,fontFamily: Appfonts.robotobold)))
          ],
          ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: AppColors.whitecolor,
                        backgroundImage: NetworkImage("${userData?.image}"),
                      ),
                      sb(20),
                      Text(
                        '${userData?.firstName} ${userData?.lastName}',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: Appfonts.robotobold
                        ),
                      ),
                      Text(
                          '${userData?.email}',
                        style: TextStyle(
                          color: AppColors.greycolor,
                          fontSize: 16,
                          fontFamily: Appfonts.roboto
                        ),
                      ),
                    ],
                  ),
                ),
                sb(20),
                Column(
                  children: [
                    UserDetailTile(icon: Icons.person_outline, title: AppLabels.full_name, subtitle: '${userData?.firstName} ${userData?.lastName}'),
                    sb(20),
                    UserDetailTile(icon: Icons.tag, title: AppLabels.user_name, subtitle: '${userData?.username}'),
                    sb(20),
                    UserDetailTile(icon: Icons.wc_outlined, title: AppLabels.gender, subtitle: '${userData?.gender}'),
                    sb(20),
                    UserDetailTile(icon: Icons.email_outlined, title: AppLabels.email, subtitle: '${userData?.email}'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget UserDetailTile({
    required IconData icon,
    required String title,
    required String subtitle,
  }){
    return ListTile(
      leading: Icon(
        icon,color: AppColors.primarycolor,
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(title,style: TextStyle(
          fontFamily: Appfonts.roboto,
          fontSize: 14,
          color: AppColors.greywithshade
        ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(subtitle,style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontSize: 20,
        ),),
      ),
    );
  }
}
