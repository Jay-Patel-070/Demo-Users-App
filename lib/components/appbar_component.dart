import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class AppbarComponent extends StatelessWidget {
  final String title;
  final Widget? leading;
  final bool? centertitle;
  final List<Widget>? actions;
  AppbarComponent({super.key,required this.title,this.centertitle = false,this.actions,this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centertitle,
      forceMaterialTransparency: true,
      title: Text(
        title,
        style: TextStyle(fontSize: AppFontSizes.xxl, fontFamily: Appfonts.robotomedium),
      ),
      actions: actions,
      leading: leading,
    );
  }
}
