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

  final List<Widget> _tabItems = [
    TopHeadlinesTabView(),
    BusinessTabView(),
    TechTabView(),
    SportsTabView(),
    HealthTabView(),
    EntertainmentTabView(),
  ];

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return DefaultTabController(
      length: _tabItems.length,
      initialIndex:
          context.select<TapBarProvider, int>((value) => value.tabBarIndex),
      child: Scaffold(
        appBar: buildHomeViewAppBar(
          context,
          isPortrait,
        ),
        body: TabBarView(
          children: _tabItems,
        ),
      ),
    );
  }
}
