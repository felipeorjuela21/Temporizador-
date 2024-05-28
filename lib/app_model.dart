import 'package:flutter/material.dart';

class App {
  final String name;
  final double usageTime;

  App({required this.name, required this.usageTime});
}

class AppModel extends ChangeNotifier {
  final List<App> _installedApps = [
    App(name: 'App 1', usageTime: 30),
    App(name: 'App 2', usageTime: 45),
  ];

  List<App> get installedApps => _installedApps;

  void addApp(App app) {
    _installedApps.add(app);
    notifyListeners();
  }

  void removeApp(App app) {
    _installedApps.remove(app);
    notifyListeners();
  }
}
