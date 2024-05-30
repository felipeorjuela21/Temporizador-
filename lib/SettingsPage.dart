import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'temporizador_viewmodel.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<TemporizadorViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Tema Claro'),
              leading: Radio(
                value: ThemeMode.light,
                groupValue: appModel.themeMode,
                onChanged: (ThemeMode? value) {
                  appModel.setThemeMode(value ?? ThemeMode.light);
                },
              ),
            ),
            ListTile(
              title: Text('Tema Oscuro'),
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: appModel.themeMode,
                onChanged: (ThemeMode? value) {
                  appModel.setThemeMode(value ?? ThemeMode.dark);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
