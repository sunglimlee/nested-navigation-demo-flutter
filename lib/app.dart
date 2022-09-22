import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/bottom_navigation.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';
import 'package:nested_navigation_demo_flutter/tab_navigator.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  var _currentTab = TabItem.red;
  final _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) { // calls the _selectTab method to update the state as needed.
    if (tabItem == _currentTab) {
      // pop to first route // QnANavigation
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst); // 한번 더 누르면 첫 화면으로 가라.
    } else {
      setState(() => _currentTab = tabItem); // setState 로 값을 바꾸고 _currentTab 에 해당하는 곳들을 다시 다 훝는다.
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // QnANavigation
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.red) {
            // select 'main' tab
            _selectTab(TabItem.red);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[ // 이부분에 Navigator 를 감싸준다는게 핵심
          // setState 가 실행될 때 마다 여기 구문들이 다시 다 실행 되니깐.. 하나만 보이는 거다.
          _buildOffstageNavigator(TabItem.red),
          _buildOffstageNavigator(TabItem.green),
          _buildOffstageNavigator(TabItem.blue),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem, // false 이면 보인다. 새로운 탭이므로 각각의 탭은 각각의 네비게이터가 존재한다.
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
