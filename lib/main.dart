import 'package:snns_cm/components/app/app_component.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:snns_cm/config/application.dart';

// My Packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';

void main() async {
  /// 初始化APP的全局变量
  ///  init router
  final router = FluroRouter();
  Routes.configureRoutes(router);
  Application.router = router;

  /// Restful API Server
  // Application.servUrl = "http://192.168.204.121:7777/api";
  Application.servUrl = "http://192.168.204.121:7777/api";

  /// Jupyter Server  "http://192.168.204.121:8888/"; "http://192.168.56.200:8899";
  Application.noteBookUrl = "http://192.168.204.121:8888";
  //Application.noteBookUrl = "http://www.baidu.com/";
  // Application.noteBookUrl =
  //     "images/scatter.html?gid=64f60172-888e-11eb-b099-7d9dfcfb793b";

  /// 默认登录信息
  // Application.isLoginined = true;
  // Application.username = 'Test@';
  // Application.usersys = true;
  // Application.useradmin = true;

  Application.isLoginined = false;

  /// 当前任务信息（id,name）
  Application.taskidNow = "";
  Application.taskNameNow = "";
  runApp(AppComponent());
}
