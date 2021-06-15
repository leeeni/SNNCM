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
import 'package:snns_cm/models/Node.dart';
import 'package:snns_cm/services/api_Node.dart';

class NodeList extends StatefulWidget {
  @override
  _NodeListState createState() => _NodeListState();
}

class _NodeListState extends State<NodeList> {
  List<PlutoColumn> titles;
  List<PlutoRow> rows = [];
  PlutoGridStateManager stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();
    _setTilte();
    _nodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('NodeList'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('NodeList'), //主界面导航栏,
              VxBox(
                child: ExpansionTile(
                  title: '集群节点服务列表'.text.size(20).bold.color(Vx.blue600).make(),
                  initiallyExpanded: true,
                  childrenPadding: const EdgeInsets.all(5),
                  expandedAlignment: Alignment.topCenter,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HStack([
                      LFlatButton(
                        child: const Text('添加'),
                        onPressed: handleAddRowButton,
                      ),
                      LFlatButton(
                        child: const Text('删除'),
                        onPressed: handleRemoveSelectedRowsButton,
                      ),
                      LFlatButton(
                        child: const Text('保存'),
                        onPressed: handleSaveSelectedRowsButton,
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
      ),

      /// Number Column definition
      PlutoColumn(
        title: '机器名',
        field: 'name',
        type: PlutoColumnType.text(),
      ),

      /// Number Column definition
      PlutoColumn(
        title: 'IP地址',
        field: 'ip',
        type: PlutoColumnType.text(),
      ),

      /// Select Column definition
      PlutoColumn(
        title: '节点说明',
        field: 'describe',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '核心数',
        field: 'cores',
        type: PlutoColumnType.text(),
      ),
    ];
  }

  /// _nodes() : 获取用户数据，并填充表格
  Future _nodes() async {
    List<Node> rs = await getNodes();
    if (mounted) {
      setState(() {
        rs.forEach((item) {
          rows.add(PlutoRow(cells: {
            'uid': PlutoCell(value: item.id),
            'name': PlutoCell(value: item.name),
            'ip': PlutoCell(value: item.ip),
            'describe': PlutoCell(value: item.describe),
            'cores': PlutoCell(value: item.cores),
          }));
        });
        this.stateManager.resetCurrentState();
        //print(rows);
      });
    }
  }

  /// 添加按钮函数
  void handleAddRowButton() async {
    final List<PlutoRow> rows = [];
    Node newNode = await addNodes("SNN", "192.168.0.1", "", 10);

    rows.add(PlutoRow(cells: {
      'uid': PlutoCell(value: newNode.id),
      'name': PlutoCell(value: newNode.name),
      'ip': PlutoCell(value: newNode.ip),
      'describe': PlutoCell(value: newNode.describe),
      'cores': PlutoCell(value: newNode.cores),
    }));
    stateManager.appendRows(rows);
  }

  /// 删除所选行函数
  void handleRemoveSelectedRowsButton() async {
    if (stateManager.currentRowIdx != null) {
      String id;
      id = stateManager.currentRow.cells.get('uid').value.toString();
      await delNode(id);
      stateManager.removeCurrentRow();
    } else {
      print('null');
    }
  }

  /// 保存所选行函数
  void handleSaveSelectedRowsButton() async {
    //print( .toString());
    if (stateManager.currentRowIdx != null) {
      await saveNodes(
        stateManager.currentRow.cells.get('uid').value,
        stateManager.currentRow.cells.get('name').value,
        stateManager.currentRow.cells.get('ip').value,
        stateManager.currentRow.cells.get('describe').value,
        int.parse(stateManager.currentRow.cells.get('cores').value.toString()),
      );
    } else {
      print('null');
    }
  }
}
