import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:temporizador/home_screen.dart';
import 'temporizador_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TemporizadorViewModel(),
      child: MaterialApp(
        title: 'Uso de Applications',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
