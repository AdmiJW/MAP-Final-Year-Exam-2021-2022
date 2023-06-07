

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/index.dart';

import 'firebase_options.dart';


Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}


final ThemeData theme = ThemeData(
  primarySwatch: Colors.blue,
);


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAP Exam',
      theme: theme,
      initialRoute: Routes.login,
      routes: Routes.routes,
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
    );
  }
}
