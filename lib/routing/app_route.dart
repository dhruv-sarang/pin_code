import 'package:flutter/material.dart';
import 'package:pin_code/screens/home/home_screen.dart';

import '../constant/app_constant.dart';
import '../screens/add_ofc/add_shop.dart';
import '../screens/allOffice/allOffice.dart';
import '../screens/splash/splash_screen.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstant.splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case AppConstant.homeScreen:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );

      case AppConstant.addOfficeFormScreen:
        return MaterialPageRoute(
          builder: (context) => AddOfficeForm(),
        );

      case AppConstant.allOffice:
        return MaterialPageRoute(
          builder: (context) => AllOffice(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
