import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/config/routes.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';
import 'package:snns_cm/models/Task.dart';
import 'package:snns_cm/services/api_Task.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<PlutoColumn> titles;
  List<PlutoRow> rows = [];
  PlutoGridStateManager stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();
    _setTilte();
    _tasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('TaskList'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('TaskList'), //主界面导航栏,
              VxBox(
                child: ExpansionTile(
                  title: '模拟任务列表'.text.size(20).bold.color(Vx.blue600).make(),
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
                  expandedAlignment: Alignment.topCenter,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HStack([
                      LFlatButton(
                        child: const Text('删除'),
                        onPressed: handleDelTaskButton,
                      ),
                      LFlatButton(
                        child: const Text('查看脉冲发放图'),
                        onPressed: () {
                          Application.router
                              .navigateTo(context, Routes.taskReplaySC);
                        },
                      ),
                      LFlatButton(
                        child: const Text('查看神经电位图'),
                        onPressed: () {
                          Application.router
                              .navigateTo(context, Routes.taskReplayOS);
                        },
                      ),
                    ])
                  ],
                ),
              ).withDecoration(boxDecorationNONE).make().p(5),
              VxBox(
                child: PlutoGrid(
                  columns: titles,
                  rows: rows,
                  mode: PlutoGridMode.select,
                  onChanged: (PlutoGridOnChangedEvent event) {
                    //setState(() {});
                    print(event);
                    PlutoRow tr = this.rows[event.rowIdx];
                    tr.cells.values.forEach((f) => print(f.value));
                    PlutoCell tc = tr.cells['taskid'];
                    print(tc.value);
                  },
                  onSelected: (PlutoGridOnSelectedEvent event) {
                    setState(() {
                      PlutoCell tc = stateManager.currentRow.cells['taskid'];
                      print(tc.value);
                      Application.taskidNow = tc.value;
                      tc = stateManager.currentRow.cells['name'];
                      print(tc.value);
                      Application.taskNameNow = tc.value;
                    });
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    stateManager.setSelectingMode(PlutoGridSelectingMode.row);
                  },
                ),
              ).withDecoration(boxDecorationNONE).make().p(5).expand(),
              GcBottomBar(),
            ],
          ).expand()
        ]),
      ).color(Vx.gray100).make(),
    );
  }

  /// _setTitle : 设置表格的标题
  void _setTilte() {
    titles = [
      /// Text Column definition
      PlutoColumn(
        title: 'UID',
        field: 'uid',
        type: PlutoColumnType.text(),
        width: 0,
      ),

      /// Text Column definition
      PlutoColumn(
        title: '任务ID',
        field: 'taskid',
        type: PlutoColumnType.text(),
        width: 400,
      ),

      /// Number Column definition
      PlutoColumn(
        title: '任务名称',
        field: 'name',
        type: PlutoColumnType.text(),
        width: 400,
      ),

      /// Select Column definition
      PlutoColumn(
        title: '说明描述',
        field: 'describe',
        type: PlutoColumnType.text(),
        width: 400,
      ),
    ];
  }

  /// _tasks() : 获取任务数据，并填充表格
  Future _tasks() async {
    List<Task> rs = await getTasks();
    if (mounted) {
      setState(() {
        rs.forEach((item) {
          rows.add(PlutoRow(cells: {
            'uid': PlutoCell(value: item.id),
            'taskid': PlutoCell(value: item.taskid),
            'name': PlutoCell(value: item.name),
            'describe': PlutoCell(value: item.describe),
          }));
        });
        this.stateManager.resetCurrentState();
        //print(rows);
      });
    }
  }

  /// 添加按钮函数
  /// 删除所选行函数
  void handleDelTaskButton() async {
    if (stateManager.currentRowIdx != null) {
      String id;
      id = stateManager.currentRow.cells.get('uid').value;
      await delTask(id);
      stateManager.removeCurrentRow();
    } else {
      print('null');
    }
  }
}
