/*
 * @Author GS
 */

import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/questions.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => Home());
      case 'questions':
        return MaterialPageRoute(
            builder: (_) => Questions(
                  data: settings.arguments,
                ));
    }
  }
}
