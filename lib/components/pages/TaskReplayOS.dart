import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';
//import 'dart:io';

html.IFrameElement _elementOS;

class TaskReplayOS extends StatefulWidget {
  @override
  _TaskReplayOSState createState() => _TaskReplayOSState();
}

class _TaskReplayOSState extends State<TaskReplayOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('TaskReplay'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('TaskReplay'), //主界面导航栏,
              VxBox(
                  child: ExpansionTile(
                title:
                    '任务数据回放-神经电位图'.text.size(20).bold.color(Vx.blue600).make(),
                subtitle: ("( 当前任务为：" +
                        Application.taskidNow +
                        " >> " +
                        Application.taskNameNow +
                        ")")
                    .text
                    .size(16)
                    .color(Vx.blue300)
                    .make(),
                initiallyExpanded: true,
                childrenPadding: const EdgeInsets.all(5),
                expandedAlignment: Alignment.topLeft,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HStack([
                    LFlatButton(
                      child: const Text('选择任务'),
                      onPressed: () {
                        Application.router.navigateTo(context, Routes.taskList);
                      },
                    ),
                    LFlatButton(
                      child: const Text('刷新数据'),
                      onPressed: () {
                        var usernamePara = "username=" + Application.username;
                        // var gidPara =
                        //     "gid=ce525f66-a2cf-4c63-b067-7175d82421d3";
                        var gidPara = "gid=" + Application.taskidNow;
                        var ttPara = "tt=100000000";
                        _elementOS.src = "images/line-stack.html?" +
                            usernamePara +
                            "&" +
                            gidPara +
                            "&" +
                            ttPara;
                        // _elementOS.src =
                        //     "images/line-stack.html?gid=ce525f66-a2cf-4c63-b067-7175d82421d3&tt=5000";
                      },
                    ),
                  ])
                ],
              )).withDecoration(boxDecorationNONE).make().p(5),
              VxBox(
                child: EchartsOSBox(),
              )
                  .withDecoration(boxDecorationNONE)
                  .shadowXs
                  .makeCentered()
                  .p(5)
                  .expand(),
              GcBottomBar(),
            ],
          ).expand()
        ]),
      ).color(Vx.gray100).make(),
    );
  }
}

class EchartsOSBox extends StatefulWidget {
  @override
  _EchartsOSBoxState createState() => _EchartsOSBoxState();
}

class _EchartsOSBoxState extends State<EchartsOSBox> {
  @override
  void initState() {
    Application.stopTime = "OS";
    //注册
    _elementOS = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/line-simple.html";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsOS',
      (int viewId) => _elementOS,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsOS'),
    );
  }
}
