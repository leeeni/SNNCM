import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/MonitorData.dart';

// getMonitorData() - 从服务端获取 [CPU/MEM] 数据
Future<MonitorData> getMonitorData(String host) async {
  // Uri(host: )
  var responseMD = await http
      .get((Uri.parse(Application.servUrl + '/v1/monitor/gethostcpu/' + host)));
  // print(responseMD.body.toString());

  var dataMD = json.decode(responseMD.body);
  // print(dataMD);
  // print(dataMD['data']);
  dynamic mdJson = dataMD['data'];

  // print(mdJson);
  MonitorData md = MonitorData();
  MonitorData md1 = MonitorData();
  MonitorData md2 = MonitorData();
  md1.fromJsonCpu(mdJson);

  var responseMD1 = await http
      .get((Uri.parse(Application.servUrl + '/v1/monitor/gethostmem/' + host)));
//  print(response.body.toString());

  //var bodyMD1 = responseMD1.body;
  var dataMD1 = json.decode(responseMD1.body);
  dynamic mdJson1 = dataMD1['data'];

  md2.fromJsonMem(mdJson1);

  md.host = md1.host;
  md.cpu = md1.cpu;
  md.mem = md2.mem;

  // print(dataMD);
  // print(dataMD1);
  // print('----------');
  // print(md.host);
  // print(md.cpu);
  // print(md.mem);

  return md;
}
