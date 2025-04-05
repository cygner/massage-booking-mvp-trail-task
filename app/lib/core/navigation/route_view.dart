import 'package:booking_app_mvp_test/features/login/presentation/pages/login_page.dart';
import 'package:booking_app_mvp_test/features/register/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import 'routes.dart';

extension RouteView on Routes {
  MaterialPageRoute route(RouteSettings settings) {
    Widget page;
    switch (this) {
      case Routes.splash:
        page = SplashPage();
        break;

        case Routes.login:
        page = LoginPage();
        break;

      case Routes.register:
        page = RegisterPage();
        break;

      case Routes.home:
        page = HomePage();
        break;
    }
    return MaterialPageRoute(builder: (context) => page, settings: settings);
  }
}
