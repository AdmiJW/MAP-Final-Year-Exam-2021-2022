
import 'package:flutter/material.dart';

import '../edit_screen.dart';
import '../home_screen.dart';
import '../login_screen.dart';


class Routes {

  static const String login = '/login';
  static const String home = '/home';
  static const String edit = '/edit';

  static final Map<String, WidgetBuilder> routes = {
    login: LoginScreen.route(),
    home: HomeScreen.route(),
    edit: EditScreen.route(),
  };

}