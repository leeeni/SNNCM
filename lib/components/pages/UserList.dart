import 'package:flutter/material.dart';
import "package:velocity_x/velocity_x.dart";
import 'package:liquid_ui/liquid_ui.dart';
//import 'package:fl_chart/fl_chart.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:snns_cm/comm/comm.dart';
import 'package:snns_cm/components/toolsbar/menu.dart';
import 'package:snns_cm/components/toolsbar/topbar.dart';
import 'package:snns_cm/components/toolsbar/bottombar.dart';
import 'package:snns_cm/models/User.dart';
import 'package:snns_cm/services/api_User.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<PlutoColumn> titles;
  List<PlutoRow> rows = [];
  PlutoGridStateManager stateManager;
  PlutoGridSelectingMode gridSelectingMode = PlutoGridSelectingMode.row;

  @override
  void initState() {
    super.initState();
    _setTilte();
    _users();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: VxBox(
        child: HStack([
          GcMenu('UserList'), //左侧主菜单栏
          VStack(
            //主界面（导航栏、功能区、底部信息栏）
            [
              GcTopBar('UserList'), //主界面导航栏,
              VxBox(
                child: ExpansionTile(
                  title: '用户资料列表'.text.size(20).bold.color(Vx.blue600).make(),
                  subtitle: "( 用户状态， 0:新注册， 1：注册通过， 2：禁用 )"
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
                      // LFlatButton(
                      //   child: const Text('添加'),
                      //   onPressed: handleAddRowButton,
                      // ),
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
        title: '用户名',
        field: 'username',
        type: PlutoColumnType.text(),
      ),

      /// Select Column definition
      PlutoColumn(
        title: '系统权限',
        field: 'rolesys',
        type: PlutoColumnType.select([false, true]),
      ),

      /// Select Column definition
      PlutoColumn(
        title: '管理权限',
        field: 'roleadmin',
        type: PlutoColumnType.select([false, true]),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: '用户状态',
        field: 'state',
        type: PlutoColumnType.select([0, 1, 2]),
      ),
    ];
  }

  /// _users() : 获取用户数据，并填充表格
  Future _users() async {
    List<User> rs = await getUsers();
    if (mounted) {
      setState(() {
        rs.forEach((item) {
          rows.add(PlutoRow(cells: {
            'uid': PlutoCell(value: item.id),
            'username': PlutoCell(value: item.username),
            'rolesys': PlutoCell(value: item.rolesys),
            'roleadmin': PlutoCell(value: item.roleadmin),
            'state': PlutoCell(value: item.state),
          }));
        });
        this.stateManager.resetCurrentState();
        //print(rows);
      });
    }
  }

  /// 添加按钮函数
  void handleAddRowButton() {
    final List<PlutoRow> rows = [];
    User item;
    rows.add(PlutoRow(cells: {
      'uid': PlutoCell(value: item.id),
      'username': PlutoCell(value: item.username),
      'rolesys': PlutoCell(value: item.rolesys),
      'roleadmin': PlutoCell(value: item.roleadmin),
      'state': PlutoCell(value: item.state),
    }));
    stateManager.appendRows(rows);
  }

  /// 删除所选行函数
  void handleRemoveSelectedRowsButton() async {
    if (stateManager.currentRowIdx != null) {
      String id;
      id = stateManager.currentRow.cells.get('uid').value.toString();
      await delUser(id);
      stateManager.removeCurrentRow();
    } else {
      print('null');
    }
  }

  /// 保存所选行函数
  void handleSaveSelectedRowsButton() async {
    //print( .toString());
    if (stateManager.currentRowIdx != null) {
      await updateUser(
        stateManager.currentRow.cells.get('uid').value,
        stateManager.currentRow.cells.get('username').value,
        stateManager.currentRow.cells.get('rolesys').value,
        stateManager.currentRow.cells.get('roleadmin').value,
        int.parse(stateManager.currentRow.cells.get('state').value.toString()),
      );
    } else {
      print('null');
    }
  }
}
