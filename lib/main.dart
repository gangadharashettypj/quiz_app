import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      initialRoute: 'home',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 28, 180, 252),
      ),
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
