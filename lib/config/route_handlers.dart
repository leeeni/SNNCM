import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:snns_cm/components/home/login_screen.dart';
import 'package:snns_cm/components/home/pcl_login_screen.dart';
import 'package:snns_cm/components/app/app_component.dart';
import 'package:snns_cm/components/home/home_component.dart';
import 'package:snns_cm/components/pages/MonitorCluster.dart';
import 'package:snns_cm/components/pages/MonitorPC.dart';
import 'package:snns_cm/components/pages/TaskList.dart';
import 'package:snns_cm/components/pages/TaskDetails.dart';
import 'package:snns_cm/components/pages/TaskReplaySC.dart';
import 'package:snns_cm/components/pages/TaskReplayOS.dart';
import 'package:snns_cm/components/pages/TaskReplayHT.dart';
import 'package:snns_cm/components/pages/NodeList.dart';
import 'package:snns_cm/components/pages/UserList.dart';
import 'package:snns_cm/components/pages/TimeListSeting.dart';
import 'package:snns_cm/components/pages/TimeListApply.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AppComponent();
});

var monitorClusterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MonitorCluster();
});

var monitorPcHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MonitorPC();
});

var taskListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskList();
});

var taskDetailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskDetails();
});

var taskReplaySCHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskReplaySC();
});

var taskReplayHTHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskReplayHT();
});

var taskReplayOSHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskReplayOS();
});

var nodeListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NodeList();
});

var userListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserList();
});

var timelistsetingHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TimeListSeting();
});

var timelistapplyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TimeListApply();
});

var helpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskList();
});

var aboutHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskList();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginScreen();
});

var pclloginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PclLoginScreen();
});
