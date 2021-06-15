import 'package:flutter/material.dart';
import 'package:liquid_ui/liquid_ui.dart';
import 'package:flutter_login/flutter_login.dart';
//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/components/home/login_screen.dart';
import 'package:snns_cm/components/home/login_mode_choose.dart';
import 'package:snns_cm/components/home/home_component.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AppComponent extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(data.name)) {
        return 'Username not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final router = FluroRouter();
    // Routes.configureRoutes(router);
    // Application.router = router;
    final app = LiquidApp(
      materialApp: MaterialApp(
        title: 'Welcome to PCL SNN Cluster',
        //home: Application.isLoginined ? HomeComponent() : LoginScreen(),
        home: Application.isLoginined ? HomeComponent() : LoginChooseScreen(),
      ),
    );

    return app;
  }
}
