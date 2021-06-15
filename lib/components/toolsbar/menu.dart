import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'package:fluttericon/typicons_icons.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';

class GcMenu extends StatelessWidget {
  GcMenu(this.selecteditem);
  final String selecteditem;
  static const KEY_MONCL = 'MonitorCluster';
  static const KEY_MONPC = 'MonitorPC';

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    final gcm = VxBox(
      child: ListView(
        children: <Widget>[
          //Menu00: Logo
          menuTopHeader(context),
          Container(height: 2, color: Colors.grey[300]),
          //Menu01: 资源监控
          menuHeader(context, '资源监控'),
          LListGroup(
            direction: Axis.vertical,
            selectedTextColor: Colors.white,
            selectedBackgroundColor: Colors.blue[300],
            disabledBackgroundColor: Colors.grey[300],
            dense: true,
            children: [
              menuButton(context, '集群监控', 'MonitorCluster',
                  Application.usersys || Application.useradmin),
              menuButton(context, '节点监控', 'MonitorPC',
                  Application.usersys || Application.useradmin),
            ],
          ),
          // Menu02 : 任务管理
          menuHeader(context, '任务管理'),
          LListGroup(
            direction: Axis.vertical,
            selectedTextColor: Colors.white,
            selectedBackgroundColor: Colors.blue[300],
            disabledBackgroundColor: Colors.grey[300],
            dense: true,
            children: [
              menuButton(context, '时段申请', 'TimeListApply', Application.usersys),
              menuButton(context, '任务运行', 'TaskDetails', Application.usersys),
              menuButton(context, '任务清单', 'TaskList', Application.usersys),
              menuButton(context, '脉冲发放图', 'TaskReplaySC', Application.usersys),
              menuButton(context, '神经电位图', 'TaskReplayOS', Application.usersys),
              // menuButton(context, '电位热力图', 'TaskReplayHT', Application.usersys),
            ],
          ),
          // Menu03 : 系统设置
          menuHeader(context, '系统设置'),
          LListGroup(
            direction: Axis.vertical,
            selectedTextColor: Colors.white,
            selectedBackgroundColor: Colors.blue[300],
            disabledBackgroundColor: Colors.grey[300],
            dense: true,
            children: [
              menuButton(context, '集群节点', 'NodeList', Application.useradmin),
              menuButton(context, '用户权限', 'UserList', Application.useradmin),
              menuButton(
                  context, '时段管理', 'TimeListSeting', Application.useradmin),
//              menuButton(context, '使用帮助', 'Help'),
              menuButton(context, '关于', 'About',
                  Application.usersys || Application.useradmin),
            ],
          ),
        ],
      ),
    ).width(200).withDecoration(boxDecorationNONE).shadowXs.make();
    return gcm;
  }

// helpers - MenuHeader
  Widget menuHeader(BuildContext context, String title) {
    return LHeaderTag(
      child: LText(
        title,
        baseStyle: TextStyle(fontSize: 22, color: Colors.blue),
        textAlign: TextAlign.center,
      ),
      tagColor: Colors.blue,
      tagHeight: 40,
    );
  }

// helpers - MenuButton
  Widget menuButton(
      BuildContext context, String title, String key, bool active) {
    return LListItem(
      selected: active && (this.selecteditem == key),
      title: LText(title,
          baseStyle: active
              ? TextStyle(fontSize: 18, color: Colors.blue[700])
              : TextStyle(fontSize: 18, color: Colors.grey[700])),
      leading: Icon(
        Typicons.right_open_outline,
        color: active ? Colors.blue[700] : Colors.grey[700],
      ),
      onTap: () {
        if (active) {
          tappedMenuButton(context, key);
        }
      },
    );
  }

// actions
  void tappedMenuButton(BuildContext context, String key) {
    String message = "";
    String hexCode = "#FFFFFF";
    String result;

    String route = "/demo?message=$message&color_hex=$hexCode";

    switch (key) {
      case 'MonitorCluster':
        Application.router.navigateTo(context, Routes.monitorCluster);
        break;
      case 'MonitorPC':
        Application.router.navigateTo(context, Routes.monitorPC);
        break;
      case 'TaskList':
        Application.router.navigateTo(context, Routes.taskList);
        break;
      case 'TaskDetails':
        Application.router.navigateTo(context, Routes.taskDetails);
        break;
      case 'TaskReplaySC':
        Application.router.navigateTo(context, Routes.taskReplaySC);
        break;
      case 'TaskReplayHT':
        Application.router.navigateTo(context, Routes.taskReplayHT);
        break;
      case 'TaskReplayOS':
        Application.router.navigateTo(context, Routes.taskReplayOS);
        break;
      case 'NodeList':
        Application.router.navigateTo(context, Routes.nodeList);
        break;
      case 'UserList':
        Application.router.navigateTo(context, Routes.userList);
        break;
      case 'TimeListSeting':
        Application.router.navigateTo(context, Routes.timelistseting);
        break;
      case 'TimeListApply':
        Application.router.navigateTo(context, Routes.timelistapply);
        break;
      case 'Help':
        Application.router.navigateTo(context, Routes.help);
        break;
      case 'About':
        Application.router.navigateTo(context, Routes.root);
        break;
    }
    //Application.router.navigateTo(context, "/demo/func?message=$message");
  }

// helpers - MenuHeader
  Widget menuTopHeader(BuildContext context) {
    final mth = VxBox(
      child: Column(
        children: [
          Image.asset("images/pcl_logo.png"),
          HeightBox(5),
          '类脑原型机'.text.color(Vx.orange400).size(26).make(),
          '管理平台'.text.color(Vx.orange400).size(26).make(),
        ],
      ),
    ).width(200).height(150).color(Vx.blue600).make();
    return mth;
  }
}
