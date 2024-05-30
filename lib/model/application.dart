import 'dart:typed_data';

class Application {
  final String appName;
  final String packageName;
  final Uint8List? icon; // Asegúrate de usar Uint8List para el ícono
  Duration totalUsage;
  List<int> weeklyUsage;

  Application({
    required this.appName,
    required this.packageName,
    this.icon,
    this.totalUsage = Duration.zero,
    this.weeklyUsage = const [0, 0, 0, 0, 0, 0, 0],
  });

  // Getter para calcular el uso promedio
  double get averageUsage {
    int totalMinutes = weeklyUsage.reduce((a, b) => a + b);
    return totalMinutes / weeklyUsage.length;
  }

  Map<String, dynamic> toJson() {
    return {
      'appName': appName,
      'packageName': packageName,
      'icon':
          icon, // Asegúrate de manejar la serialización del ícono si es necesario
      'totalUsage': totalUsage.inMinutes,
      'weeklyUsage': weeklyUsage,
    };
  }

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      appName: json['appName'],
      packageName: json['packageName'],
      icon: json['icon'] != null
          ? Uint8List.fromList(List<int>.from(json['icon']))
          : null,
      totalUsage: Duration(minutes: json['totalUsage']),
      weeklyUsage: List<int>.from(json['weeklyUsage']),
    );
  }
}
