import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'temporizador_viewmodel.dart';
import 'timer_screen.dart';
import 'usage_chart.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplicaciones Instaladas'),
        backgroundColor: Colors.teal,
      ),
      body: Consumer<TemporizadorViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.installedApps.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: viewModel.installedApps.length,
                  itemBuilder: (context, index) {
                    var app = viewModel.installedApps[index];
                    bool isSelected = viewModel.trackedApps.contains(app);

                    return Card(
                      color: isSelected ? Colors.teal[100] : Colors.white,
                      child: ListTile(
                        leading: app.icon != null
                            ? Image.memory(app.icon! as Uint8List,
                                width: 40, height: 40)
                            : const Icon(Icons.device_unknown, size: 40),
                        title: Text(app.appName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(app.packageName),
                        trailing: isSelected
                            ? IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.red),
                                onPressed: () => viewModel.untrackApp(app),
                              )
                            : IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Colors.green),
                                onPressed: () => viewModel.trackApp(app),
                              ),
                        onTap: isSelected
                            ? null
                            : () {
                                viewModel.trackApp(app);
                              },
                      ),
                    );
                  },
                ),
              ),
              const UsageChart(),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimerScreen()),
                  );
                },
                child: const Text('Ver Gráfico de Uso'),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Aplicaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Gráfica',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        onTap: (index) {},
      ),
    );
  }
}
