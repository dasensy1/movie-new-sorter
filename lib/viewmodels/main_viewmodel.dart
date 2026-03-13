import 'package:flutter/foundation.dart';

enum MainTab {
  films,
  profile,
  settings,
}

class MainViewModel extends ChangeNotifier {
  MainTab _currentTab = MainTab.films;

  MainTab get currentTab => _currentTab;

  void setTab(MainTab tab) {
    if (_currentTab != tab) {
      _currentTab = tab;
      notifyListeners();
    }
  }
}
