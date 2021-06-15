import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
//import 'package:editable/editable.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';
import 'package:snns_cm/models/TimeList.dart';
import 'package:snns_cm/services/api_TimeList.dart';

class TimeListSeting extends StatefulWidget {
  @override
  _TimeListSetingState createState() => _TimeListSetingState();
}

class _TimeListSetingState extends State<TimeListSeting> {
  List<PlutoColumn> titles;
  List<PlutoRow> rows = [];
  PlutoGridStateManager stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();
    _setTilte();
    _TimeLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('TimeListSeting'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('TimeListSeting'), //主界面导航栏,
              VxBox(
                child: ExpansionTile(
                  title: '集群服务时段列表'.text.size(20).bold.color(Vx.blue600).make(),
                  subtitle: "( 时段状态， 0:空闲， 1：申请中， 2：审批通过 )"
                      .text
                      .size(16)
                      .color(Vx.blue400)
                      .make(),
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.all(5),
                  expandedAlignment: Alignment.topCenter,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HStack([
                      LFlatButton(
                        child: const Text('添加时段资源'),
                        onPressed: handleAddRowButton,
                      ),
                      LFlatButton(
                        child: const Text('批准申请'),
                        onPressed: handlePZButton,
                      ),
                      LFlatButton(
                        child: const Text('释放时段资源'),
                        onPressed: handleSFButton,
                      ),
                      LFlatButton(
                        child: const Text('删除'),
                        onPressed: handleRemoveSelectedRowsButton,
                      ),
                    ])
                  ],
                ),
              ).withDecoration(boxDecorationNONE).make().p(5),

              VxBox(
                child: PlutoGrid(
                  columns: titles,
                  rows: rows,
                  onChanged: (PlutoGridOnChangedEvent event) {
                    //setState(() {});
                    print(event);
                    PlutoRow tr = this.rows[event.rowIdx];
                    tr.cells.values.forEach((f) => print(f.value));
                    PlutoCell tc = tr.cells['uid'];
                    print(tc.value);
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    stateManager = event.stateManager;
                    // stateManager.setSelectingMode(gridSelectingMode);
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
        enableEditingMode: false,
        width: 0,
      ),

      /// Number Column definition
      PlutoColumn(
        title: '时段名称',
        field: 'name',
        type: PlutoColumnType.text(),
      ),

      /// Number Column definition
      PlutoColumn(
        title: '日期',
        field: 'rdate',
        type: PlutoColumnType.text(),
      ),

      /// Select Column definition
      PlutoColumn(
        title: '时间号',
        field: 'rhourse',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '节点数',
        field: 'notes',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '时段状态',
        field: 'state',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '用户名',
        field: 'username',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '用户ID',
        field: 'userid',
        type: PlutoColumnType.text(),
        width: 0,
      ),
    ];
  }

  /// _Times() : 获取用户数据，并填充表格
  Future _TimeLists() async {
    List<TimeList> rs = await getTimeLists();
    if (mounted) {
      setState(() {
        rs.forEach((item) {
          rows.add(PlutoRow(cells: {
            'uid': PlutoCell(value: item.id),
            'name': PlutoCell(value: item.name),
            'rdate': PlutoCell(value: item.rdate),
            'rhourse': PlutoCell(value: item.rhourse),
            'notes': PlutoCell(value: item.notes),
            'state': PlutoCell(value: item.state),
            'username': PlutoCell(value: item.username),
            'userid': PlutoCell(value: item.userid),
          }));
        });
        this.stateManager.resetCurrentState();
        //print(rows);
      });
    }
  }

  /// 添加按钮函数
  void handleAddRowButton() async {
    var result = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        cancelText: "取消",
        confirmText: "确定");
    var dd = result.year.toString() +
        "." +
        result.month.toString() +
        "." +
        result.day.toString();

    final List<PlutoRow> rows = [];

    for (var i = 1; i <= 24; i++) {
      TimeList newTime = await addTimeLists(
          dd + "服务时段" + i.toString(), dd, i.toString(), 9, "", "", 0);
      print(dd + "服务时段" + i.toString());
      rows.add(PlutoRow(cells: {
        'uid': PlutoCell(value: newTime.id),
        'name': PlutoCell(value: newTime.name),
        'rdate': PlutoCell(value: newTime.rdate),
        'rhourse': PlutoCell(value: newTime.rhourse),
        'notes': PlutoCell(value: newTime.notes),
        'state': PlutoCell(value: newTime.state),
        'username': PlutoCell(value: newTime.username),
        'userid': PlutoCell(value: newTime.userid),
      }));
      stateManager.appendRows(rows);
    }
  }

  /// 删除所选行函数
  void handleRemoveSelectedRowsButton() async {
    if (stateManager.currentRowIdx != null) {
      String id;
      id = stateManager.currentRow.cells.get('uid').value.toString();
      await delTimeList(id);
      stateManager.removeCurrentRow();
    } else {
      print('null');
    }
  }

  /// 保存所选行函数
  void handlePZButton() async {
    //print( .toString());
    stateManager.currentRow.cells.get('state').value = 2;
    if (stateManager.currentRowIdx != null) {
      await saveTimeLists(
        stateManager.currentRow.cells.get('uid').value,
        stateManager.currentRow.cells.get('name').value,
        stateManager.currentRow.cells.get('rdate').value,
        stateManager.currentRow.cells.get('rhourse').value,
        int.parse(stateManager.currentRow.cells.get('notes').value.toString()),
        stateManager.currentRow.cells.get('userid').value,
        stateManager.currentRow.cells.get('username').value,
        int.parse(stateManager.currentRow.cells.get('state').value.toString()),
      );
    } else {
      print('null');
    }
  }

  /// 保存所选行函数
  void handleSFButton() async {
    //print( .toString());
    stateManager.currentRow.cells.get('state').value = 0;
    stateManager.currentRow.cells.get('userid').value = "";
    stateManager.currentRow.cells.get('username').value = "";
    if (stateManager.currentRowIdx != null) {
      await saveTimeLists(
        stateManager.currentRow.cells.get('uid').value,
        stateManager.currentRow.cells.get('name').value,
        stateManager.currentRow.cells.get('rdate').value,
        stateManager.currentRow.cells.get('rhourse').value,
        int.parse(stateManager.currentRow.cells.get('notes').value.toString()),
        stateManager.currentRow.cells.get('userid').value,
        stateManager.currentRow.cells.get('username').value,
        int.parse(stateManager.currentRow.cells.get('state').value.toString()),
      );
    } else {
      print('null');
    }
  }
}
