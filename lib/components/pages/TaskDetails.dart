import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'dart:html' as html;
import 'package:universal_ui/universal_ui.dart';
import 'package:uuid/uuid.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';
import 'package:snns_cm/services/api_Task.dart';
import 'package:snns_cm/services/api_UserPod.dart';
import 'package:snns_cm/components/pages/TaskList.dart';

// 使用外部跳转跳转到jupyter lab
import 'package:url_launcher/url_launcher.dart';

_launchURL() async {
  var hostPort = await getUserPodHostPort(Application.username);
  var url = 'http://192.168.204.121:' + hostPort.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class TaskDetails extends StatelessWidget {
//   @override
//   _MonitorPCState createState() => _MonitorPCState();
// }
// class _MonitorPCState extends State<MonitorPC> {
  final TextEditingController _controllerUID = new TextEditingController();
  final TextEditingController _controllerName = new TextEditingController();
  final TextEditingController _controllerDescribe = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('TaskDetails'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('TaskDetails'),
              VxBox(
                  child: ExpansionTile(
                title: '模拟任务运行'.text.size(20).bold.color(Vx.blue600).make(),
                //"( 远程运行环境登录密码：test123 )"
                subtitle: "".text.size(16).color(Vx.blue400).make(),
                initiallyExpanded: true,
                childrenPadding: const EdgeInsets.all(5),
                expandedAlignment: Alignment.topRight,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HStack([
                    LFlatButton(
                      child: const Text('新建任务'),
                      onPressed: handleAddTaskButton,
                    ),
                    LFlatButton(
                      child: const Text('保存任务'),
                      onPressed: handleSaveTaskButton,
                    ),
                    LFlatButton(
                      child: const Text('进入jupyter lab'),
                      onPressed: _launchURL,
                    ),
                    LFlatButton(
                      child: const Text('查看任务列表'),
                      onPressed: () {
                        Application.router.navigateTo(context, Routes.taskList);
                      },
                    ),
                    // LFlatButton(
                    //   child: const Text('查看脉冲发放图'),
                    //   onPressed: () {
                    //     Application.router
                    //         .navigateTo(context, Routes.taskReplaySC);
                    //   },
                    // ),
                    // LFlatButton(
                    //   child: const Text('查看电位热力图'),
                    //   onPressed: () {
                    //     Application.router
                    //         .navigateTo(context, Routes.taskReplayHT);
                    //   },
                    // ),
                  ])
                ],
              )).withDecoration(boxDecorationNONE).make().p(5), //主界面导航栏,
              VxBox(
                child: Row(children: [
                  TextField(
                    controller: _controllerUID,
                    readOnly: true,
                    decoration: new InputDecoration(
                      labelText: "UID",
                      hintText: '自动生成，不能修改',
                    ),
                  ).w(350).p(5),
                  TextField(
                    controller: _controllerName,
                    decoration: new InputDecoration(
                      labelText: "任务名称",
                      hintText: '请输入任务名称',
                    ),
                  ).w(350).p(5),
                  TextField(
                    controller: _controllerDescribe,
                    decoration: new InputDecoration(
                      labelText: "说明描述",
                      hintText: '请简单描述一下任务情况',
                    ),
                  ).w(500).p(5),
                ]),
              ).withDecoration(boxDecorationNONE).make().p(5),
              VxBox(
                child: CodeMirrorBox(),
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

  /// 添加按钮函数
  void handleAddTaskButton() {
    var uuid = Uuid();
    var now = new DateTime.now();
    _controllerUID.text = uuid.v4();
    _controllerName.text = "仿真任务-" +
        now.year.toString() +
        now.month.toString() +
        now.day.toString() +
        now.hour.toString() +
        now.minute.toString();
    _controllerDescribe.text = "";
    Application.taskidNow = _controllerUID.text;
    Application.taskNameNow = _controllerName.text;
  }

  /// 删除所选行函数
  void handleSaveTaskButton() {
    Application.taskidNow = _controllerUID.text;
    Application.taskNameNow = _controllerName.text;
    saveTasks(
        _controllerUID.text, _controllerName.text, _controllerDescribe.text);
    //stateManager.removeCurrentRow();
  }
}

class CodeMirrorBox extends StatefulWidget {
  @override
  _CodeMirrorBoxState createState() => _CodeMirrorBoxState();
}

class _CodeMirrorBoxState extends State<CodeMirrorBox> {
  html.IFrameElement _element;
  @override
  void initState() {
    //注册
    _element = html.IFrameElement()
      ..style.border = 'none'
      ..src = Application.noteBookUrl;
    //屏蔽报错
    // ignore:undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'webInWeb',
      (int viewId) => _element,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //web视图
      child:
          // WebNode(
          //   node: html.DivElement()
          //     ..style.textAlign = 'center'
          //     ..append(html.AnchorElement()
          //       ..href = Application.noteBookUrl
          //       ..appendText('A link to dart.dev')),
          // ),
          //     WebBrowser(
          //   initialUrl: Application.noteBookUrl,
          //   javascriptEnabled: true,
          // ),
          HtmlElementView(viewType: 'webInWeb'),
    );
  }
}
