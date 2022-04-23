import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';

errorWidget() {
  return ErrorWidget.builder = ((details) {
    return Material(
      child: Container(
        color: whiteColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/bad_request_error.png'),
                const SizedBox(height: 20.0),
                Text(
                  details.exception.toString(),
                  style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
