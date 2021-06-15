import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/User.dart';

// getUsers() - 从服务端获取 [用户] 数据
Future<List<User>> getUsers() async {
  var response =
      await http.get(Uri.parse(Application.servUrl + '/v1/user/selectuser'));
//  print(response.body.toString());

  var body = response.body;
  var dataUser = json.decode(response.body);
//  print(data);
  List<dynamic> userJson = dataUser['data'];
  // print(userJson);
  List<User> users = [];
  userJson.forEach(
    (json) => users.add(
      User.fromJson(json),
    ),
  );
  // print(users.length);
  // print(users);
  return users;
}

// signup() - 向服务端注册 [用户]
Future<http.Response> signup(String name, String password) async {
  var post = {
    "username": "${name}",
    "password": "${password}",
  };
  var taskbody = utf8.encode(json.encode(post));
  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/user/signup'),
      headers: {"content-type": "application/json"},
      body: taskbody);

  //var body = response.body;
  print("${response.statusCode}");
  print("${response.body}");
  // var dataTask = json.decode(responseTask.body);
  // List<dynamic> taskJson = dataTask['data'];
  // List<Task> tasks = [];
  // taskJson.forEach(
  //   (json) => tasks.add(
  //     Task.fromJson(json),
  //   ),
  // );
  return response;
}

// login() - 向服务端登陆 [用户]
Future<http.Response> login(String name, String password) async {
  var post = {
    "username": "${name}",
    "password": "${password}",
  };
  var taskbody = utf8.encode(json.encode(post));
  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/user/login'),
      headers: {"content-type": "application/json"},
      body: taskbody);
  print(response.toString());
  print("${response.headers}");
  print(response.headers);
  print(response.request);
  print(response);
  return response;
}

// pcllogin() - 向服务端登陆 [云脑用户]
Future<http.Response> pcllogin(String name, String password) async {
  var post = {
    "username": "${name}",
    "password": "${password}",
  };
  var taskbody = utf8.encode(json.encode(post));
  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/pcluser/login'),
      headers: {"content-type": "application/json"},
      body: taskbody);

  //var body = response.body;
  print("${response.statusCode}");
  print("${response.body}");
  // var dataTask = json.decode(responseTask.body);
  // List<dynamic> taskJson = dataTask['data'];
  // List<Task> tasks = [];
  // taskJson.forEach(
  //   (json) => tasks.add(
  //     Task.fromJson(json),
  //   ),
  // );
  return response;
}

// updateUser() - 向服务端保存 [任务] 数据
Future<http.Response> updateUser(String uid, String username, bool rolesys,
    bool roleadmin, int state) async {
  var url = Uri.parse(Application.servUrl + '/v1/user/updateuser');
  var post = {
    "uid": "${uid}",
    "username": "${username}",
    "rolesys": rolesys,
    "roleadmin": roleadmin,
    "state": state,
  };
  var nodebody = utf8.encode(json.encode(post));
  //print(nodebody);
  var response = await http.post(url,
      headers: {"content-type": "application/json"}, body: nodebody);

  //print("${response.statusCode}");
  //print("${response.body}");

  return response;
}

// delUser() - 删除 [用户] 数据
Future<http.Response> delUser(String id) async {
  var response =
      await http.get(Uri.parse(Application.servUrl + '/v1/user/deluser/' + id));
  return response;
}

// logout() - 用户登出
Future<http.Response> logout() async {
  var url = Uri.parse(Application.servUrl + '/v1/user/logout');

  var response = await http.delete(url);

  return response;
}

// 'id': id,
// 'name': username,
// 'password': password,
// 'rolesys': rolesys,
// 'roleadmin': roleadmin,
// 'state': state,
