// lib/model/application.dart
class Application {
  final String appName;
  final String packageName;
  final String? icon;
  Duration totalUsage;
  List<int> weeklyUsage;

  Application({
    required this.appName,
    required this.packageName,
    this.icon,
    this.totalUsage = Duration.zero,
    this.weeklyUsage = const [0, 0, 0, 0, 0, 0, 0],
  });

  double get averageUsage => totalUsage.inMinutes / 7;

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      appName: json['appName'],
      packageName: json['packageName'],
      icon: json['icon'],
      totalUsage: Duration(minutes: json['totalUsage']),
      weeklyUsage: List<int>.from(json['weeklyUsage']),
    );
  }

  Map<String, dynamic> toJson() => {
        'appName': appName,
        'packageName': packageName,
        'icon': icon,
        'totalUsage': totalUsage.inMinutes,
        'weeklyUsage': weeklyUsage,
      };
}
