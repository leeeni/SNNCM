import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'package:fluttericon/typicons_icons.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';
import 'package:snns_cm/services/api_User.dart';

class GcTopBar extends StatelessWidget {
  GcTopBar(this.idkey);
  final String idkey;
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    final gctbar = ZStack(
      [
        VxBox(
          child: Row(
            children: [
              WidthBox(10),
              Icon(Typicons.th_list, color: Colors.blueGrey[300]),
              WidthBox(10),
              breadCrumb(context, this.idkey),
            ],
          ),
        )
            .alignCenterLeft
            .height(45)
            .withDecoration(boxDecorationTLF)
            .shadowXs
            .make()
            .p(5),
        VxBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              WidthBox(10),
              Text(
                '[ ' + Application.username + ' ]',
              ).text.color(Colors.blue[300]).make().p(5),
              WidthBox(10),
              LFlatButton(
                child: const Text('退出'),
                onPressed: () {
                  logout();
                  Application.isLoginined = false;
                  Application.router.navigateTo(context, Routes.root);
                },
              ),
            ],
          ),
        ).alignCenterRight.height(45).width(350).make().p(5),
      ],
      alignment: Alignment.centerRight,
    );
    return gctbar;
  }

// helpers - BreadCrumb
  Widget breadCrumb(BuildContext context, String idkey) {
    LBreadCrumbs bc;
    switch (idkey) {
      case 'Home':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
          ],
        );
        break;
      case 'MonitorCluster':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '资源监控', ''),
            breadCrumbItem(context, '集群监控', ''),
          ],
        );
        break;
      case 'MonitorPC':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '资源监控', ''),
            breadCrumbItem(context, '节点监控', ''),
          ],
        );
        break;
      case 'TaskList':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '任务管理', ''),
            breadCrumbItem(context, '任务列表', ''),
          ],
        );
        break;
      case 'TimeListApply':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '任务管理', ''),
            breadCrumbItem(context, '时段申请', ''),
          ],
        );
        break;
      case 'TaskDetails':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '任务管理', ''),
            breadCrumbItem(context, '任务运行', ''),
          ],
        );
        break;
      case 'TaskReplay':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '任务管理', ''),
            breadCrumbItem(context, '任务回放', ''),
          ],
        );
        break;
      case 'NodeList':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '系统管理', ''),
            breadCrumbItem(context, '集群节点', ''),
          ],
        );
        break;
      case 'UserList':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '系统管理', ''),
            breadCrumbItem(context, '用户权限', ''),
          ],
        );
        break;
      case 'TimeListSeting':
        bc = LBreadCrumbs(
          items: [
            breadCrumbItem(context, '首页', ''),
            breadCrumbItem(context, '系统管理', ''),
            breadCrumbItem(context, '时段设置', ''),
          ],
        );
        break;
    }
    return bc;
  }

// helpers - BreadCrumbItem
  Widget breadCrumbItem(BuildContext context, String title, String key) {
    LBreadCrumbItem bci;
    bci = LBreadCrumbItem(
      title,
      activeColor: Colors.green[600],
      active: true,
      onTap: () {
        tappedBreadCrumbItem(context, key);
      },
    );
    return bci;
  }

// actions - BreadCrumbItem
  void tappedBreadCrumbItem(BuildContext context, String key) {
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
      case '':
      case '':
      case '':
    }

    //Application.router.navigateTo(context, "/demo/func?message=$message");
  }
}
