import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class BuildTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) changed;

  const BuildTextFormField({Key? key, required this.changed, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: changed,
      cursorColor: greyColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
        filled: true,
        fillColor: appGreyColor,
        prefixIcon: const Icon(
          Icons.search,
          size: 20.0,
          color: greyColor,
        ),
        labelText: 'search tooltip'.tr(),
        labelStyle: const TextStyle(
          fontSize: 16.0,
          color: greyColor,
        ),
        enabledBorder: _buildTextFieldBorder(),
        focusedBorder: _buildTextFieldBorder(),
        focusedErrorBorder: _buildTextFieldBorder(),
        errorBorder: _buildTextFieldBorder(),
      ),
    );
  }

  OutlineInputBorder _buildTextFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: appGreyColor),
    );
  }
}

class BuildSearchInitialWidget extends StatelessWidget {
  const BuildSearchInitialWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/images/initial search.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class BuildSearchEmptyWidget extends StatelessWidget {
  const BuildSearchEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              'assets/images/nodata.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class BuildSearchErrorWidget extends StatelessWidget {
  final String image, errorMessage;

  const BuildSearchErrorWidget({Key? key, required this.image, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              image,
              height: 300.0,
              width: 300.0,
              fit: BoxFit.fill,
            ),
            Text(
              errorMessage,
              style: const TextStyle(
                color: blackColor,
                fontSize: 22.0,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
