import 'package:flutter/material.dart';

import 'app_model.dart';

class AppListItem extends StatelessWidget {
  final App app;

  AppListItem({required this.app});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(app.name),
      subtitle: Text('Uso: ${app.usageTime} minutos'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Implementar lógica para desseleccionar la aplicación
        },
      ),
    );
  }
}
