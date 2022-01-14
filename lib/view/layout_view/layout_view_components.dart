import 'package:akhbary_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

BottomNavigationBarItem _buildBottomNavigationBarItem({
  @required int index,
  @required int selectedIndex,
  @required IconData selectedIcon,
  @required IconData unselectedIcon,
  @required String toolTip,
}) {
  return BottomNavigationBarItem(
    label: '',
    tooltip: toolTip,
    icon: Align(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2.5,
            width: 35,
            color: index == selectedIndex ? appMainColor : appGreyColor,
            margin: EdgeInsets.only(bottom: 7.0),
          ),
          Icon(
            index == selectedIndex ? selectedIcon : unselectedIcon,
            size: index == selectedIndex ? 27.0 : 23.0,
          ),
        ],
      ),
    ),
  );
}

List<BottomNavigationBarItem> buildBottomNavigationBarItems({
  @required int index,
}) {
  return [
    _buildBottomNavigationBarItem(
      index: index,
      selectedIndex: 0,
      selectedIcon: Icons.home,
      unselectedIcon: Icons.home_outlined,
      toolTip: 'home tooltip'.tr(),
    ),
    _buildBottomNavigationBarItem(
      index: index,
      selectedIndex: 1,
      selectedIcon: Icons.search,
      unselectedIcon: Icons.search_outlined,
      toolTip: 'search tooltip'.tr(),
    ),
    _buildBottomNavigationBarItem(
      index: index,
      selectedIndex: 2,
      selectedIcon: Icons.bookmark,
      unselectedIcon: Icons.bookmark_border_outlined,
      toolTip: 'saved tooltip'.tr(),
    ),
    _buildBottomNavigationBarItem(
      index: index,
      selectedIndex: 3,
      selectedIcon: Icons.settings,
      unselectedIcon: Icons.settings,
      toolTip: 'Setting'.tr(),
    ),
  ];
}

class BuildBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function onClick;

  BuildBottomNavigationBar(
      {@required this.selectedIndex, @required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 1.5,
          width: double.infinity,
          color: appGreyColor,
        ),
        BottomNavigationBar(
          selectedFontSize: 0,
          onTap: onClick,
          currentIndex: selectedIndex,
          items: buildBottomNavigationBarItems(
            index: selectedIndex,
          ),
        ),
      ],
    );
  }
}
