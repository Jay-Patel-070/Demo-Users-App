import 'package:demo_users_app/cm.dart';
import 'package:demo_users_app/components/appbar_component.dart';
import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/users/edit_screen.dart';
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
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, true);   // return true to previous screen
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppbarComponent(
            centertitle: true,
            title: AppLabels.user_details,
            leading: IconButton(onPressed: () {
              Navigator.pop(context,true);
            }, icon: Icon(Icons.arrow_back)),
            actions: [
              TextButton(
                onPressed: () {
                  callNextScreenWithResult(context, EditScreen()).then((value) {
                    if (value == true) {
                      Cm.showSnackBar(
                        context,
                        message: AppStrings.user_details_updated_successfully,
                        bg: AppColors.greencolor,
                      );
                      setState(() {});
                    } else {
                      Cm.showSnackBar(
                        context,
                        message: AppStrings.no_changes_made_to_user_details,
                        bg: AppColors.greycolor,
                      );
                    }
                  });
                },
                child: Text(
                  AppLabels.edit,
                  style: TextStyle(
                    color: AppColors.primarycolor,
                    fontSize: AppFontSizes.xl,
                    fontFamily: Appfonts.robotobold,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.greywithshade.withValues(alpha: 0.2),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppColors.whitecolor,
                            backgroundImage: NetworkImage("${userData?.image}"),
                          ),
                        ),
                        sb(20),
                        Text(
                          '${userData?.firstName} ${userData?.lastName}',
                          style: TextStyle(
                            fontSize: AppFontSizes.xl,
                            fontFamily: Appfonts.robotobold,
                          ),
                        ),
                        Text(
                          '${userData?.email}',
                          style: TextStyle(
                            color: AppColors.greycolor,
                            fontSize: AppFontSizes.lg,
                            fontFamily: Appfonts.roboto,
                          ),
                        ),
                      ],
                    ),
                  ),
                  sb(20),
                  Column(
                    children: [
                      UserDetailTile(
                        icon: Icons.person_outline,
                        title: AppLabels.full_name,
                        subtitle: '${userData?.firstName} ${userData?.lastName}',
                      ),
                      sb(20),
                      UserDetailTile(
                        icon: Icons.tag,
                        title: AppLabels.user_name,
                        subtitle: '${userData?.username}',
                      ),
                      sb(20),
                      UserDetailTile(
                        icon: Icons.wc_outlined,
                        title: AppLabels.gender,
                        subtitle: '${userData?.gender}',
                      ),
                      sb(20),
                      UserDetailTile(
                        icon: Icons.email_outlined,
                        title: AppLabels.email,
                        subtitle: '${userData?.email}',
                      ),
                    ],
                  ),
                ],
              ),
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
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primarycolor),
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.lg),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontSize: AppFontSizes.md,
            color: AppColors.greywithshade,
          ),
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.lg),
        child: Text(
          subtitle,
          style: TextStyle(
            fontFamily: Appfonts.roboto,
            fontSize: AppFontSizes.xl,
          ),
        ),
      ),
    );
  }
}
