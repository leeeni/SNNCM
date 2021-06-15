import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {
  static String root = "/index";
  static String monitorCluster = "/monitorCluster";
  static String monitorPC = "/monitorPC";
  static String taskList = "/taskList";
  static String taskDetails = "/taskDetails";
  static String taskReplaySC = "/taskReplaySC";
  static String taskReplayHT = "/taskReplayHT";
  static String taskReplayOS = "/taskReplayOS";
  static String nodeList = "/nodeList";
  static String userList = "/userList";
  static String timelistseting = "/timelistseting";
  static String timelistapply = "/timelistapply";
  static String help = "/help";
  static String about = "/about";

  static String login = "/login";
  static String pcllogin = "/pcllogin";

  static String demoFunc = "/demo/func";
  static String deepLink = "/message";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: rootHandler);
    router.define(monitorCluster, handler: monitorClusterHandler);
    router.define(monitorPC, handler: monitorPcHandler);
    router.define(taskList, handler: taskListHandler);
    router.define(taskDetails, handler: taskDetailsHandler);
    router.define(taskReplaySC, handler: taskReplaySCHandler);
    router.define(taskReplayHT, handler: taskReplayHTHandler);
    router.define(taskReplayOS, handler: taskReplayOSHandler);
    router.define(nodeList, handler: nodeListHandler);
    router.define(userList, handler: userListHandler);
    router.define(timelistseting, handler: timelistsetingHandler);
    router.define(timelistapply, handler: timelistapplyHandler);
    router.define(help, handler: helpHandler);
    router.define(about, handler: aboutHandler);

    router.define(login, handler: loginHandler);
    router.define(pcllogin, handler: pclloginHandler);
    //router.define(demoSimpleFixedTrans,
    //    handler: demoRouteHandler, transitionType: TransitionType.inFromLeft);
    //router.define(demoFunc, handler: demoFunctionHandler);
    //router.define(deepLink, handler: deepLinkHandler);  Routes.timelistseting
  }
}
