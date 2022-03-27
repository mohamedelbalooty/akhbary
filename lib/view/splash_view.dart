import 'dart:async';
import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'app_components.dart';
import 'layout_view/layout_view.dart';

class SplashView extends StatefulWidget {
  static const String id = 'SplashView';

  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LayoutView()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 205.0,
              width: 200.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 5.0),
            GradientText(
              'app name'.tr(),
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade200,
                  appMainColor,
                ],
              ),
              style: const TextStyle(
                fontSize: 45.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
