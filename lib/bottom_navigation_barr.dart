import 'package:demo_users_app/main.dart';
import 'package:demo_users_app/screens/product/product_screen.dart';
import 'package:demo_users_app/screens/users/all_user_screen.dart';
import 'package:demo_users_app/screens/users/settings_screen.dart';
import 'package:demo_users_app/utils/utils.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarr extends StatefulWidget {
  const BottomNavigationBarr({super.key});

  @override
  State<BottomNavigationBarr> createState() => _BottomNavigationBarrState();
}

class _BottomNavigationBarrState extends State<BottomNavigationBarr> {
  final List screens = [
    AllUserScreen(),
    SettingsScreen(),
    ProductScreen()
  ];

  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BoxBorder.fromLTRB(
            top: BorderSide(
              color: AppColors.secondarycolor.withOpacity(0.2),
              style: BorderStyle.solid
            ),
          )
        ),
        child: BottomNavigationBar(
            items:const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                label: AppLabels.users,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: AppLabels.settings,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: AppLabels.products,
              )
            ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: AppColors.whitecolor,
          unselectedItemColor: AppColors.greywithshade,
          selectedItemColor: AppColors.primarycolor,
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: AppFontSizes.md,
          unselectedFontSize: AppFontSizes.md,
          unselectedLabelStyle: TextStyle(
            fontFamily: Appfonts.robotomedium
          ),
          selectedLabelStyle: TextStyle(
            fontFamily: Appfonts.robotobold
          ),
        ),
      )
    );
  }
}
