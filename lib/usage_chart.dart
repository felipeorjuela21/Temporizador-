import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/application.dart' as my_app;
import 'temporizador_viewmodel.dart';

class UsageChart extends StatelessWidget {
  const UsageChart({super.key});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<TemporizadorViewModel>(context);
    final data = appModel.trackedApps;

    // Si no hay aplicaciones rastreadas, mostrar un mensaje
    if (data.isEmpty) {
      return const Center(child: Text('No hay aplicaciones rastreadas.'));
    }

    List<ChartData> chartData = [];
    for (int i = 0; i < data.length; i++) {
      chartData
          .add(ChartData(data[i].appName, data[i].averageUsage.toDouble()));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.appName,
            yValueMapper: (ChartData data, _) => data.usage,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class ChartData {
  final String appName;
  final double usage;

  ChartData(this.appName, this.usage);
}
