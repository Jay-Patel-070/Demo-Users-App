import 'dart:ui';

import 'package:flutter/material.dart';

// class AppColors {
//   static Color primarycolor = Color(0xFF4A90E2);
//   static Color secondarycolor = Color(0x964A90E2);
//   static const Color greywithshade = Color.fromRGBO(117, 117, 117, 1);
//   static const Color greywithshade2 = Color.fromRGBO(231, 226, 226, 1.0);
//   static Color whitecolor = Colors.white;
//   static const Color greencolor = Colors.green;
//   static const Color transparent = Colors.transparent;
//   static Color blackcolor = Colors.black;
//   static Color greycolor = Colors.grey;
//   static const Color redcolor = Colors.red;
//   static const Color redwithshade = Color(0xFF8B0000);
//   static Color bordercolor = Colors.grey;
//   static Color rating = Colors.amber;
// }

class AppColors {
  // These values will change from ThemeBloc
  static Color primarycolor = const Color(0xFF4A90E2);
  static Color secondarycolor = const Color(0x964A90E2);

  static Color greywithshade = const Color.fromRGBO(117, 117, 117, 1);
  static Color greywithshade2 = const Color.fromRGBO(231, 226, 226, 1.0);

  static Color whitecolor = Colors.white;
  static Color blackcolor = Colors.black;

  static Color greycolor = Colors.grey;

  static Color bordercolor = Colors.grey;
  static Color rating = Colors.amber;

  // THESE 2 WON’T CHANGE
  static const Color greencolor = Colors.green;
  static const Color redcolor = Colors.red;
  static const Color transparent = Colors.transparent;
  static const Color redwithshade = Color(0xFF8B0000);
}

class AppLabels {
  static const String demo_users_app = "Demo users app";
  static const String login = 'Log in';
  static const String full_name = 'Full Name';
  static const String first_name = 'First Name';
  static const String last_name = 'Last Name';
  static const String male = 'Male';
  static const String female = 'Female';
  static const String age = 'Age';
  static const String gender = 'Gender';
  static const String email = 'Email';
  static const String user_name = 'Username';
  static const String password = 'Password';
  static const String create_account = 'Create Account';
  static const String user_details = 'User Details';
  static const String log_in = 'Log In';
  static const String users = 'Users';
  static const String edit = 'Edit';
  static const String settings = 'Settings';
  static const String general = 'General';
  static const String profile = 'Profile';
  static const String theme = 'Theme';
  static const String system = 'System';
  static const String account = 'Account';
  static const String logout = 'Logout';
  static const String delete_account = 'Delete Account';
  static const String edit_profile = 'Edit Profile';
  static const String save_changes = 'Save changes';
  static const String products = 'Products';
  static const String product_details = 'Product Details';
  static const String add_to_cart = 'Add to Cart';
  static const String skip = 'skip';
  static const String previous = 'previous';
  static const String next = 'next';
  static const String product_description = "Product Description";
  static const String stock = "Stock";
  static const String sku = "SKU";
}

class AppStrings {
  static const String log_in_to_your_account = 'Log in to your account';
  static const String enter_your_username = 'Enter your Username';
  static const String enter_your_password = 'Enter your password';
  static const String forgot_password = 'Forgot Password?';
  static const String new_to_our_app = 'New to our app?';
  static const String create_your_account = 'Create Your Account';
  static const String john = 'John';
  static const String exampleage = 'e.g., 25';
  static const String exampleemail = 'you@example.com';
  static const String enter_a_strong_password = 'Enter a strong password';
  static const String already_have_an_account = 'Already have an account?';
  static const String search_by_name_or_email = 'Search by name or email...';
  static const String Search = 'Search...';
  static const String search_products_by_name_or_sku = 'Search Products by name or sku';
  static const String welcome_back_online = 'Welcome back online';
  static const String oops_you_are_offline = 'oops! you are offline';
  static const String user_details_updated_successfully = 'User details updated successfully';
  static const String no_changes_made_to_user_details = 'No changes made to user details';
  static const String error_fetching_product_details = 'Error fetching product details';
}

class Appfonts {
  static const String roboto = 'Roboto';
  static const String robotomedium = 'Robotomedium';
  static const String robotobold = 'Robotobold';
  static const String obotobolditalic = 'Robotobolditalic';
  static const String robotomediumitalic = 'Robotomediumitalic';
}

class LocalStorageKeys {
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String userData = "userData";
}

class AppFontSizes {
  static const double xs = 10;
  static const double sm = 12;
  static const double md = 14;  // primary body text
  static const double lg = 16;  // common title text
  static const double xl = 18;
  static const double xxl = 22;
  static const double display = 28;
}

class AppRadius {
  static const double xs = 4;
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 12;
  static const double xl = 16;
  static const double circle = 1000;
}

class AppPadding {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

class AppSizes {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}