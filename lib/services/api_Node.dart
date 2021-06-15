import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/Node.dart';

//String url = "http://127.0.0.1:80/api";
//final Box userBox = Hive.box('userBox');
//var token = userBox.get('token');

// var url = 'http://127.0.0.1:80/api/v1/node/insertnode';
// var node =
//     new Node(name: 'test3', ip: '202.116.130.1', describe: 'SNN03 test3');
// print(jsonEncode(node).toString());
// var response = await http.post(url, body: jsonEncode(node).toString());
// print(response.body.toString());

// getNodes() - 从服务端获取 [节点] 数据
Future<List<Node>> getNodes() async {
  var response =
      await http.get(Uri.parse(Application.servUrl + '/v1/node/selectnode'));
//  var body = response.body;
//  print(response.body.toString());
  var dataNode = json.decode(response.body);
//  print(data);
  List<dynamic> tnodeJson = dataNode['data'];
  // print(tnodeJson);
  List<Node> nodes = [];
  tnodeJson.forEach(
    (json) => nodes.add(
      Node.fromJson(json),
    ),
  );
  // print(nodes.length);
  // print(nodes);
  return nodes;
}

// addNodes() - 向服务端保存 [任务] 数据
Future<Node> addNodes(
    String name, String ip, String describe, int cores) async {
  var post = {
    "name": "${name}",
    "ip": "${ip}",
    "describe": "${describe}",
    "cores": cores,
  };
  var nodebody = utf8.encode(json.encode(post));

  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/node/insertnode'),
      headers: {"content-type": "application/json"},
      body: nodebody);

  var dataNode = json.decode(response.body);
//  print(data);
  return Node.fromJson(dataNode['data']);
}

// saveNodes() - 向服务端保存 [任务] 数据
Future<http.Response> saveNodes(
    String uid, String name, String ip, String describe, int cores) async {
  var url = Uri.parse(Application.servUrl + '/v1/node/updatenode');
  var post = {
    "uid": "${uid}",
    "name": "${name}",
    "ip": "${ip}",
    "describe": "${describe}",
    "cores": cores,
  };
  var nodebody = utf8.encode(json.encode(post));
  //print(nodebody);
  var response = await http.post(url,
      headers: {"content-type": "application/json"}, body: nodebody);

  //var body = response.body;
  //print("${response.statusCode}");
  //print("${response.body}");

  return response;
}

// delNode() - 删除 [节点] 数据
Future<http.Response> delNode(String id) async {
  var response =
      await http.get(Uri.parse(Application.servUrl + '/v1/node/delnode/' + id));
  return response;
}
