import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart' as device_apps;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/application.dart' as my_app;

class TemporizadorViewModel extends ChangeNotifier {
  List<my_app.Application> _installedApps = [];
  List<my_app.Application> _trackedApps = [];
  SharedPreferences? _prefs;
  ThemeMode _themeMode = ThemeMode.light;

  List<my_app.Application> get installedApps => _installedApps;
  List<my_app.Application> get trackedApps => _trackedApps;
  ThemeMode get themeMode => _themeMode;

  TemporizadorViewModel() {
    _loadPrefs();
    fetchInstalledApps();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTrackedApps();
    _loadThemeMode();
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
    List<device_apps.Application> apps =
        await device_apps.DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    );

    _installedApps = apps
        .map((app) => my_app.Application(
              appName: app.appName,
              packageName: app.packageName,
              icon: app is device_apps.ApplicationWithIcon ? app.icon : null,
            ))
        .toList();
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

  Future<void> _loadThemeMode() async {
    final String? themeMode = _prefs?.getString('theme_mode');
    if (themeMode != null) {
      _themeMode =
          ThemeMode.values.firstWhere((mode) => mode.toString() == themeMode);
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _prefs?.setString('theme_mode', mode.toString());
    notifyListeners();
  }
}
