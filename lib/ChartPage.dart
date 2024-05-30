import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/application.dart' as my_app;
import 'temporizador_viewmodel.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<TemporizadorViewModel>(context);
    final data = appModel.trackedApps;

    List<ChartData> chartData = [];
    for (int i = 0; i < data.length; i++) {
      chartData
          .add(ChartData(data[i].appName, data[i].averageUsage.toDouble()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gráfico de Uso'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <ChartSeries>[
                  LineSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.appName,
                    yValueMapper: (ChartData data, _) => data.usage,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var app = data[index];
                return ListTile(
                  title: Text(app.appName),
                  subtitle: Text('Uso diario: ${app.averageUsage} minutos'),
                );
              },
            ),
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
