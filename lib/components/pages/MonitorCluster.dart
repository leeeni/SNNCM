import 'dart:async';
import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';

/// Our sparkline data.
class MonitorCluster extends StatefulWidget {
  @override
  _MonitorClusterState createState() => _MonitorClusterState();
}

class _MonitorClusterState extends State<MonitorCluster> {
  Timer timer;
  int counter = 0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => addValue());
  }

  void addValue() {
    setState(() {
      counter++;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('MonitorCluster'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('MonitorCluster'), //主界面导航栏,
              VxBox(
                child: LColumn(children: [
                  LRow(columns: [
                    LColumn.child(
                      child: VxBox(
                        child: EchartsClusterBox01(),
                      ).withDecoration(boxDecorationNONE).shadowXs.make().p(3),
                    ),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox02(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox03(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                  ]),
                  LRow(columns: [
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox04(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox05(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox06(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                  ]),
                  LRow(columns: [
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox07(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox08(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                    LColumn.child(
                        child: VxBox(
                      child: EchartsClusterBox09(),
                    ).withDecoration(boxDecorationNONE).shadowXs.make().p(3)),
                  ]),
                ]),
              ).withDecoration(boxDecorationNONE).shadowXs.make().p(5).expand(),

              GcBottomBar(),
            ],
          ).expand()
        ]),
      ).color(Vx.gray100).make(),
    );
  }
}

// EchartsClusterBox01 -------------------------
class EchartsClusterBox01 extends StatefulWidget {
  @override
  _EchartsClusterBoxState01 createState() => _EchartsClusterBoxState01();
}

class _EchartsClusterBoxState01 extends State<EchartsClusterBox01> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN01&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster01',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster01'),
    );
  }
}

// EchartsClusterBox02 -------------------------
class EchartsClusterBox02 extends StatefulWidget {
  @override
  _EchartsClusterBoxState02 createState() => _EchartsClusterBoxState02();
}

class _EchartsClusterBoxState02 extends State<EchartsClusterBox02> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN02&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster02',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster02'),
    );
  }
}

// EchartsClusterBox03 -------------------------
class EchartsClusterBox03 extends StatefulWidget {
  @override
  _EchartsClusterBoxState03 createState() => _EchartsClusterBoxState03();
}

class _EchartsClusterBoxState03 extends State<EchartsClusterBox03> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN03&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster03',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster03'),
    );
  }
}

// EchartsClusterBox04 -------------------------
class EchartsClusterBox04 extends StatefulWidget {
  @override
  _EchartsClusterBoxState04 createState() => _EchartsClusterBoxState04();
}

class _EchartsClusterBoxState04 extends State<EchartsClusterBox04> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN04&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster04',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster04'),
    );
  }
}

// EchartsClusterBox05 -------------------------
class EchartsClusterBox05 extends StatefulWidget {
  @override
  _EchartsClusterBoxState05 createState() => _EchartsClusterBoxState05();
}

class _EchartsClusterBoxState05 extends State<EchartsClusterBox05> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN05&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster05',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster05'),
    );
  }
}

// EchartsClusterBox06 -------------------------
class EchartsClusterBox06 extends StatefulWidget {
  @override
  _EchartsClusterBoxState06 createState() => _EchartsClusterBoxState06();
}

class _EchartsClusterBoxState06 extends State<EchartsClusterBox06> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN06&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster06',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster06'),
    );
  }
}

// EchartsClusterBox07 -------------------------
class EchartsClusterBox07 extends StatefulWidget {
  @override
  _EchartsClusterBoxState07 createState() => _EchartsClusterBoxState07();
}

class _EchartsClusterBoxState07 extends State<EchartsClusterBox07> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN07&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster07',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster07'),
    );
  }
}

// EchartsClusterBox08 -------------------------
class EchartsClusterBox08 extends StatefulWidget {
  @override
  _EchartsClusterBoxState08 createState() => _EchartsClusterBoxState08();
}

class _EchartsClusterBoxState08 extends State<EchartsClusterBox08> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN08&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster08',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster08'),
    );
  }
}

// EchartsClusterBox09 -------------------------
class EchartsClusterBox09 extends StatefulWidget {
  @override
  _EchartsClusterBoxState09 createState() => _EchartsClusterBoxState09();
}

class _EchartsClusterBoxState09 extends State<EchartsClusterBox09> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = "images/cpumems.html?host=SNN09&len=60";
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'EchartsCluster09',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child: HtmlElementView(viewType: 'EchartsCluster09'),
    );
  }
}
