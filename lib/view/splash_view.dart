import 'dart:async';
import 'package:akhbary_app/utils/colors.dart';
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
    Timer(Duration(seconds: 2), () {
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
            colors: [whiteColor, appMainColor],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Hero(
          tag: 'splash',
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              height: 130.0,
              width: 130.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}
