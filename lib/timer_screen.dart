import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  final String appName;

  TimerPage({required this.appName});

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late int _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = 30; // 5 minutos
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _showTimeUpDialog();
          _timer.cancel();
        }
      });
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Tiempo terminado'),
        content: Text('¿Deseas continuar usando ${widget.appName} o cerrarla?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // Cierra el temporizador
            },
            child: Text('Cerrar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _remainingTime = 20; // Reinicia el temporizador a 5 minutos
              _startTimer();
            },
            child: Text('Continuar'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temporizador para ${widget.appName}'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'Tiempo restante: $_remainingTime segundos',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
