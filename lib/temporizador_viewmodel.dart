import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart' as device_apps;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'model/application.dart' as my_app;

class TemporizadorViewModel extends ChangeNotifier {
  List<my_app.Application> _installedApps = [];
  List<my_app.Application> _trackedApps = [];
  SharedPreferences? _prefs;

  List<my_app.Application> get installedApps => _installedApps;
  List<my_app.Application> get trackedApps => _trackedApps;

  TemporizadorViewModel() {
    _loadPrefs();
    fetchInstalledApps();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTrackedApps();
  }

  Future<void> _loadTrackedApps() async {
    final String? data = _prefs?.getString('tracked_apps');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      _trackedApps =
          jsonList.map((json) => my_app.Application.fromJson(json)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTrackedApps() async {
    final String data =
        json.encode(_trackedApps.map((app) => app.toJson()).toList());
    _prefs?.setString('tracked_apps', data);
  }

  Future<void> fetchInstalledApps() async {
    List<my_app.Application> apps =
        (await device_apps.DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    ))
            .map((app) {
      return my_app.Application(
        appName: app.appName,
        packageName: app.packageName, // assuming icon is of type Uint8List
      );
    }).toList();

    _installedApps = apps;
    notifyListeners();
  }

  void trackApp(my_app.Application app) {
    if (!_trackedApps.contains(app)) {
      _trackedApps.add(app);
      _saveTrackedApps();
      notifyListeners();
    }
  }

  void untrackApp(my_app.Application app) {
    _trackedApps.remove(app);
    _saveTrackedApps();
    notifyListeners();
  }

  void updateAppUsage(my_app.Application app, Duration usage) {
    final index = _trackedApps.indexOf(app);
    if (index != -1) {
      _trackedApps[index].totalUsage += usage;
      _trackedApps[index].weeklyUsage[DateTime.now().weekday - 1] +=
          usage.inMinutes;
      _saveTrackedApps();
      notifyListeners();
    }
  }
}
