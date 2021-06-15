import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';

html.IFrameElement _elementPC;

class MonitorPC extends StatelessWidget {
//   @override
//   _MonitorPCState createState() => _MonitorPCState();
// }
// class _MonitorPCState extends State<MonitorPC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('MonitorPC'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('MonitorPC'), //主界面导航栏,
              VxBox(
                child: EchartsPCBox(),
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

class EchartsPCBox extends StatefulWidget {
  @override
  _EchartsPCBoxState createState() => _EchartsPCBoxState();
}

class _EchartsPCBoxState extends State<EchartsPCBox> {
  @override
  void initState() {
    //注册
    _elementPC = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumem.html?len=180";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsPC',
      (int viewId) => _elementPC,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsPC'),
    );
  }
}
