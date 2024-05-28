import 'package:shared_preferences/shared_preferences.dart';
import 'package:temporizador/app_model.dart';

class AppService {
  Future<List<App>> fetchInstalledApps() async {
    // Implementar la lógica para obtener las aplicaciones instaladas
    return [];
  }

  Future<void> saveUsageTime(String appName, double usageTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(appName, usageTime);
  }

  Future<double?> getUsageTime(String appName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(appName);
  }
}
