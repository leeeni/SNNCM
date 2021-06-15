import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/UserPod.dart';

// getUserPort() - 从服务端获取 [getUserPod] 数据
Future<int> getUserPodHostPort(String username) async {
  var post = {
    "username": username,
  };
  var taskbody = utf8.encode(json.encode(post));
  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/pynnpod/get'),
      headers: {"content-type": "application/json"},
      body: taskbody);

  var dataUserPod = json.decode(response.body);
  return dataUserPod['data']['hostport'];
}
