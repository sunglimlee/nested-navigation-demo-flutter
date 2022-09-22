import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/color_detail_page.dart';
import 'package:nested_navigation_demo_flutter/colors_list_page.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';

/*
If we could use a Navigator that is not an ancestor of our BottomNavigationBar,
    then things would work as intended.
*/

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey; // We need this to uniquely identify the navigator across the entire app
  final TabItem tabItem;

  void _push(BuildContext context, {int materialIndex: 500}) { // detail 페이지를 보여주는 함수
    var routeBuilders = _routeBuilders(context, materialIndex: materialIndex); // 새롭게 만드네.

    Navigator.push( // detail page 를 보여주는 부분인데.. 가장 중요한건 품고 있는 navigator 를 찾아간다.
      // 마우스를 갖다 대어봐라. 밑에 Navigator 가 같이 선택된다
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),);
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {int materialIndex: 500}) {
    return {
      TabNavigatorRoutes.root: (context) => ColorsListPage(
            color: activeTabColor[tabItem]!,
            title: tabName[tabItem]!,
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex), // 이부분이 index list 부분에서 detail 로 넘머갈 때 navigation 을 위한 부분이다.
          ),
      TabNavigatorRoutes.detail: (context) => ColorDetailPage(
            color: activeTabColor[tabItem]!,
            title: tabName[tabItem]!,
            materialIndex: materialIndex,
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}
