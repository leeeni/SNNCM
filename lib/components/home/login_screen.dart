import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:fialogs/fialogs.dart';

//My Package
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';
import 'package:snns_cm/services/api_User.dart';

bool canlogin = false;
const mockUsers = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'near.huscarl@gmail.com': 'subscribe to pewdiepie',
  '@.com': '.',
};

class Constants {
  static const String appName = '类脑原型机集群管理平台(本地用户)';
  static const String logoTag = 'near.huscarl.loginsample.logo';
  static const String titleTag = 'near.huscarl.loginsample.title';
}

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) async {
    Application.username = '';
    Application.usersys = false;
    Application.useradmin = false;

    return Future.delayed(loginTime).then((_) async {
      http.Response RS = await login(data.name, data.password);

      var dataSignup = json.decode(RS.body);

      if (dataSignup['code'] != 0) {
        return dataSignup['message'];
      }
      //var dataUser = json.decode(dataSignup['data']);
      Application.username = dataSignup['data']['username'];
      Application.usersys = dataSignup['data']['rolesys'];
      Application.useradmin = dataSignup['data']['roleadmin'];
      print(Application.username);
      print(Application.usersys);
      print(Application.useradmin);
      return null;
    });
  }

  Future<String> _onSignup(LoginData data) async {
    Application.username = '';
    Application.usersys = false;
    Application.useradmin = false;

    return Future.delayed(loginTime).then((_) async {
      http.Response RS = await signup(data.name, data.password);
      var dataSignup = json.decode(RS.body);

      print("${dataSignup['code']}");
      print("${dataSignup['message']}");

      if (dataSignup['code'] != 0) {
        return dataSignup['message'];
      }

      print("${dataSignup['data']['username']}");
      print("${dataSignup['data']['rolesys']}");
      print("${dataSignup['data']['roleadmin']}");
      //var dataUser = json.decode(dataSignup['data']);
      Application.username = dataSignup['data']['username'];
      Application.usersys = dataSignup['data']['rolesys'];
      Application.useradmin = dataSignup['data']['roleadmin'];
      print(Application.username);
      print(Application.usersys);
      print(Application.useradmin);
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: Constants.appName,
      logo: 'images/pcl_logo.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      messages: LoginMessages(
        usernameHint: '用户名（请用邮箱）',
        passwordHint: '密码',
        confirmPasswordHint: '密码确认',
        loginButton: '登录',
        signupButton: '注册',
        forgotPasswordButton: '忘记密码了?',
        recoverPasswordButton: '帮助',
        goBackButton: '返回',
        confirmPasswordError: '密码不一致!',
        recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      emailValidator: (value) {
        //!value.contains('@') || !value.endsWith('.com') / "Email must contain '@' and end with '.com'"
        if ((value == 'root') || (value == 'admin')) {
          return null;
        }
        if (!value.contains('@')) {
          return "Email 必须包含 '@'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value.isEmpty) {
          return '密码为空';
        }
        return null;
      },
      onLogin: (loginData) async {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        //await showDialog(context: context, builder: (ctx) => CounterWidget());
        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _onSignup(loginData);
      },
      onSubmitAnimationCompleted: () {
        Application.isLoginined = true;
        Application.router.navigateTo(context, Routes.root);
        // Navigator.of(context).pushReplacement(FadePageRoute(
        //   builder: (context) => HomeComponent(),
        // ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  var a, b, c;
  var rng = new Random();
  var saveText = "";

  @override
  Widget build(BuildContext context) {
    a = rng.nextInt(1000) + 1000;
    b = rng.nextInt(1000);
    c = a + b;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Material(
            child: Container(
              width: 250,
              height: 120,
              child: VStack([
                Text("请输入下列的算式的结果作为验证码"),
                (a.toString() + "+" + b.toString() + "=?")
                    .text
                    .blue300
                    .center
                    .make(),
                //Text(a.toString() + "+" + b.toString() + "=?",textAlign: TextAlign.center,style: ,),
                TextField(
                  onChanged: (value) {
                    //保存输入框的值
                    saveText = value;
                  },
                ),
              ]),
            ),
            color: Colors.white,
          ),
          LFlatButton(
              child: const Text('确定'),
              onPressed: () {
                if (c.toString() == saveText) {
                  Navigator.of(context).pop(1);
                } else {
                  print(c);
                  print(saveText);
                }
              })
        ],
      ),
    );
  }
}
