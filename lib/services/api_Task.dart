import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/Task.dart';

// getTasks() - 从服务端获取 [任务] 数据
Future<List<Task>> getTasks() async {
  var response = await http.get(Uri.parse(
      Application.servUrl + '/v1/task/selecttask/' + Application.username));
  //var body = response.body;
  var dataTask = json.decode(response.body);
  List<dynamic> taskJson = dataTask['data'];
  List<Task> tasks = [];
  taskJson.forEach(
    (json) => tasks.add(
      Task.fromJson(json),
    ),
  );
  return tasks;
}

// saveTasks() - 向服务端保存 [任务] 数据
Future<http.Response> saveTasks(
    String taskid, String name, String describe) async {
  var post = {
    "taskid": "${taskid}",
    "name": "${name}",
    "describe": "${describe}",
    "user": "${Application.username}",
  };
  var taskbody = utf8.encode(json.encode(post));
  print(json.encode(post));
  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/task/inserttask'),
      headers: {"content-type": "application/json"},
      body: taskbody);
  print("${response.statusCode}");
  print("${response.body}");
  return response;
}

// delTask() - 删除 [任务] 数据
Future<http.Response> delTask(String id) async {
  var response = await http
      .get(Uri.parse(Application.servUrl + '/v1/task/deltask/' + id));
  return response;
}
