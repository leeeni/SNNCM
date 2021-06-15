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

html.IFrameElement _elementHT;

/////////////////////////////////////////////////////////////////////////

class TaskReplayHT extends StatefulWidget {
  @override
  _TaskReplayHTState createState() => _TaskReplayHTState();
}

class _TaskReplayHTState extends State<TaskReplayHT> {
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
                    '任务数据回放-电位热力图'.text.size(20).bold.color(Vx.blue600).make(),
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
                        //_elementHT.src =
                        //    "images/heatmap.html?gid=" + Application.taskidNow;
                        _elementHT.src =
                            "images/heatmap.html?gid=ce525f66-a2cf-4c63-b067-7175d82421d3&tt=1000";
                      },
                    ),
                  ])
                ],
              )).withDecoration(boxDecorationNONE).make().p(5),
              VxBox(
                child: EchartsHTBox(),
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

class EchartsHTBox extends StatefulWidget {
  @override
  _EchartsHTBoxState createState() => _EchartsHTBoxState();
}

class _EchartsHTBoxState extends State<EchartsHTBox> {
  @override
  void initState() {
    //注册
    _elementHT = html.IFrameElement()
      ..style.border = 'none'
      ..src =
          "images/heatmap_init.html?gid=64f60172-888e-11eb-b099-7d9dfcfb793b&tt=1";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsHT',
      (int viewId) => _elementHT,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsHT'),
    );
  }
}
