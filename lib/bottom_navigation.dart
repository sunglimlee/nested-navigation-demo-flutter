import 'package:flutter/material.dart';
import 'package:nested_navigation_demo_flutter/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab; // final VoidCallback onWaitComplete;

/*
  void ValueSetter (T Value)
  Signature for callbacks that report that a value has been set.
  This is the same signature as ValueChanged, but is used when the callback is called even if the underlying value has not changed. For example, service extensions use this callback
  because they call the callback whenever the extension is called with a value,
  regardless of whether the given value is new or not.
  typedef ValueSetter<T> = void Function(T value);
*/

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.red),
        _buildItem(TabItem.green),
        _buildItem(TabItem.blue),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: activeTabColor[currentTab]!,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? activeTabColor[item]! : Colors.grey;
  }
}
