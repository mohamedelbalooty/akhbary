import 'dart:ui';
import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../app_components.dart';

class AboutView extends StatelessWidget {
  static const String id = 'AboutView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height) * 0.6,
              width: double.infinity,
              alignment: AlignmentDirectional.topStart,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade200,
                    Colors.deepOrangeAccent,
                    Colors.redAccent.shade200,
                  ],
                ),
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(80.0),
                  bottomStart: Radius.circular(80.0),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                height: (MediaQuery.of(context).size.height) * 0.6,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  borderRadius: const BorderRadiusDirectional.only(
                    topEnd: Radius.circular(15.0),
                    topStart: Radius.circular(15.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5.0),
                        Image.asset(
                          'assets/images/logo.png',
                          height: 90.0,
                          width: 110.0,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 5.0),
                        GradientText(
                          'app name'.tr(),
                          gradient: LinearGradient(
                            colors: [
                              Colors.orange.shade300,
                              appMainColor,
                            ],
                          ),
                          style: const TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          'about_us'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).tabBarTheme.labelColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            height: 2.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
