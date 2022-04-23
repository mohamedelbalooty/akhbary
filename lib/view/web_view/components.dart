import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import '../../utils/colors.dart';

AppBar buildWebViewAppBar(BuildContext context, bool isPortrait,
        {required String author, required String source, required String url}) =>
    AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      elevation: 5.0,
      title: Text(
        'visit item'.tr(),
        style: const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        !isPortrait
            ? IconButton(
                icon: const Icon(Icons.details),
                iconSize: 24.0,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          backgroundColor:
                              Theme.of(context).appBarTheme.backgroundColor,
                          shape: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide:
                                  BorderSide(color: Colors.transparent)),
                          content: BuildWebViewBottomBar(
                              author: author, source: source, url: url),
                        );
                      });
                },
              )
            : const SizedBox(),
      ],
    );

class BuildArticleSiteDetailsWidgetItem extends StatelessWidget {
  final String title, description;

  const BuildArticleSiteDetailsWidgetItem(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: appMainColor),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).tabBarTheme.labelColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class BuildWebViewBottomBar extends StatelessWidget {
  final String author, source, url;

  const BuildWebViewBottomBar(
      {Key? key, required this.author, required this.source, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ((author == '') || (source == ''))
        ? Container(
            height: 100.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  color: (Theme.of(context).tabBarTheme.labelColor!)
                      .withOpacity(0.5),
                  blurRadius: 3,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: BuildArticleSiteDetailsWidgetItem(
              title: 'source'.tr(),
              description: url,
            ),
          )
        : Container(
            height: 150.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  color: (Theme.of(context).tabBarTheme.labelColor!)
                      .withOpacity(0.5),
                  blurRadius: 3,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildArticleSiteDetailsWidgetItem(
                  title: 'author'.tr(),
                  description: author == '' ? source : author,
                ),
                const Divider(
                  color: appMainColor,
                  thickness: 2.0,
                  height: 30.0,
                ),
                BuildArticleSiteDetailsWidgetItem(
                  title: 'source'.tr(),
                  description: source == '' ? author : source,
                ),
              ],
            ),
          );
  }
}
