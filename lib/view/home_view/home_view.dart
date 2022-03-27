import 'package:akhbary_app/provider/tap_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view_components.dart';
import 'tabs/business_tab_view.dart';
import 'tabs/entertainment_tab_view.dart';
import 'tabs/health_tab_view.dart';
import 'tabs/sports_tab_view.dart';
import 'tabs/tech_tab_view.dart';
import 'tabs/top_headlines_tab_view.dart';

class HomeView extends StatelessWidget {
  static const String id = 'HomeView';

  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return DefaultTabController(
      length: 6,
      initialIndex:
          context.select<TapBarProvider, int>((value) => value.tabBarIndex),
      child: Scaffold(
        appBar: buildHomeViewAppBar(
          context,
          isPortrait,
        ),
        body: const TabBarView(
          children: [
            TopHeadlinesTabView(),
            BusinessTabView(),
            TechTabView(),
            SportsTabView(),
            HealthTabView(),
            EntertainmentTabView(),
          ],
        ),
      ),
    );
  }
}
