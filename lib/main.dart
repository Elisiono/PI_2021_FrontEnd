import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_projeto/screens/home/home_screen.dart';
import 'package:flutter_projeto/screens/login_screen.dart';
import 'package:process_run/which.dart';
import 'package:desktop_window/desktop_window.dart';

void main() async {
  Process.run('node', ['index.js'],
          workingDirectory: 'D:/Documentos/ProjetoPrisma/src')
      .then((value) => print('run ${value.stdout} ${value.stderr}'))
      .catchError((_) => print('error'));
  runApp(const MyApp());
  Size size = await DesktopWindow.getWindowSize();
  print(size);
  await DesktopWindow.setWindowSize(Size(500, 900));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Cliente',
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.blueAccent,
              primaryVariant: Colors.lightBlue.shade400,
              secondary: Colors.green,
              secondaryVariant: Colors.lightGreen.shade400,
            ),
      ),
      home: LoginScreen(),
      //home: HomeScreen(),
    );
  }
}
