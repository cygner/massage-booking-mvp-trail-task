import 'package:booking_app_mvp_test/core/navigation/goto.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../core/navigation/routes.dart';
import '../../../../core/storage/session/sesssion.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() async {
      var isLoggedIn = await SessionManager.isLoggedIn();
      if(context.mounted){
        context.pushReplacementNamed(isLoggedIn?Routes.home:Routes.login);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: FlutterLogo(size: 100,),),
    );
  }
}
