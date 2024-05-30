import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temporizador/home_screen.dart';
import 'ChartPage.dart';
import 'SettingsPage.dart';
import 'temporizador_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TemporizadorViewModel(),
      child: MaterialApp(
        title: 'Uso de Aplicaciones',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: {
          '/chart': (context) => ChartPage(),
          '/settings': (context) => SettingsPage(),
        },
      ),
    );
  }
}
