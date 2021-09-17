import 'dart:async';

import 'package:akhbary_app/services/local_services/cache_helper.dart';
import 'package:akhbary_app/utils/app_constants.dart';
import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'layout_view/layout_view.dart';

class SplashView extends StatefulWidget {
  static const String id = 'SplashView';

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    CacheHelper.setBooleanData(key: sharedPrefsSplashKey, value: true);
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LayoutView.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [whiteColor, Colors.deepOrangeAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo.png',
            height: 120.0,
            width: 120.0,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
