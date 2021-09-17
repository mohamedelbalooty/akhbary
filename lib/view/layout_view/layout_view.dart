import 'package:akhbary_app/provider/app_provider.dart';
import 'package:akhbary_app/view/home_view/home_view.dart';
import 'package:akhbary_app/view/saved_view/saved_view.dart';
import 'package:akhbary_app/view/search_view/search_view.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'layout_view_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LayoutView extends StatelessWidget {
  static const String id = 'LayoutView';
  final List<Widget> _layoutScreens = [
    HomeView(),
    SearchView(),
    SavedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        body: _layoutScreens[context
            .select<AppProvider, int>((value) => value.bottomNavBarIndex)],
        bottomNavigationBar: BuildBottomNavigationBar(
          selectedIndex: context
              .select<AppProvider, int>((value) => value.bottomNavBarIndex),
          onClick: (int currentIndex) {
            context.read<AppProvider>().changeBottomNavBarIndex(currentIndex);
          },
        ),
      ),
    );
  }
}
