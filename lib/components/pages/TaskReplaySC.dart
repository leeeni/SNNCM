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

html.IFrameElement _elementSC;

class TaskReplaySC extends StatefulWidget {
  @override
  _TaskReplaySCState createState() => _TaskReplaySCState();
}

class _TaskReplaySCState extends State<TaskReplaySC> {
  @override
  void initState() {
    super.initState();
  }

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
                    '任务数据回放-脉冲发放图'.text.size(20).bold.color(Vx.blue600).make(),
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
                        // var usernamePara = "username=" + Application.username;
                        // var gidPara = "gid =" + Application.taskidNow;
                        // var ttPara = "tt=100000000";
                        var usernamePara = "username=" + Application.username;
                        // var gidPara =
                        //     "gid=ce525f66-a2cf-4c63-b067-7175d82421d3";
                        var gidPara = "gid=" + Application.taskidNow;
                        var ttPara = "tt=100000000";
                        print(gidPara);
                        _elementSC.src = "images/scatter.html?" +
                            usernamePara +
                            "&" +
                            gidPara +
                            "&" +
                            ttPara;
                      },
                    ),
                  ])
                ],
              )).withDecoration(boxDecorationNONE).make().p(5),
              VxBox(
                child: EchartsSCBox(),
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

class EchartsSCBox extends StatefulWidget {
  @override
  _EchartsSCBoxState createState() => _EchartsSCBoxState();
}

class _EchartsSCBoxState extends State<EchartsSCBox> {
  @override
  void initState() {
    //注册
    _elementSC = html.IFrameElement()
      ..style.border = 'none'
      ..src =
          "images/scatter_init.html?gid=d0408b31-0a57-4352-a6f4-b16b2232e9d7";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsSC',
      (int viewId) => _elementSC,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsSC'),
    );
  }
}
