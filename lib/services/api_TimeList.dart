import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

//My packages
import 'package:snns_cm/config/application.dart';
import 'package:snns_cm/models/TimeList.dart';

// getTimeLists() - 从服务端获取 [时间段] 数据
Future<List<TimeList>> getTimeLists() async {
  var response = await http
      .get(Uri.parse(Application.servUrl + '/v1/timelist/selecttimelist'));
//  var body = response.body;
//  print(response.body.toString());
  var dataTimeList = json.decode(response.body);
//  print(data);
  List<dynamic> ttimelistJson = dataTimeList['data'];
  // print(ttimelistJson);
  List<TimeList> timelists = [];
  ttimelistJson.forEach(
    (json) => timelists.add(
      TimeList.fromJson(json),
    ),
  );
  // print(timelists.length);
  // print(timelists);
  return timelists;
}

// getTimeLists() - 从服务端获取 [时间段] 数据
Future<List<TimeList>> getTimeListsByUN(String username) async {
  var response = await http.get(Uri.parse(
      Application.servUrl + '/v1/timelist/selecttimelistun/' + username));
//  var body = response.body;
//  print(response.body.toString());
  var dataTimeList = json.decode(response.body);
//  print(data);
  List<dynamic> ttimelistJson = dataTimeList['data'];
  // print(ttimelistJson);
  List<TimeList> timelists = [];
  ttimelistJson.forEach(
    (json) => timelists.add(
      TimeList.fromJson(json),
    ),
  );
  // print(timelists.length);
  // print(timelists);
  return timelists;
}

// addTimeLists() - 向服务端保存 [时间段] 数据
Future<TimeList> addTimeLists(String name, String rdate, String rhourse,
    int notes, String userid, String username, int state) async {
  var post = {
    'name': "${name}",
    'rdate': "${rdate}",
    'rhourse': "${rhourse}",
    'notes': notes,
    'userid': "${userid}",
    'username': "${username}",
    'state': state,
  };
  var timelistbody = utf8.encode(json.encode(post));

  var response = await http.post(
      Uri.parse(Application.servUrl + '/v1/timelist/inserttimelist'),
      headers: {"content-type": "application/json"},
      body: timelistbody);

  var dataTimeList = json.decode(response.body);
//  print(data);
  return TimeList.fromJson(dataTimeList['data']);
}

// saveTimeLists() - 向服务端保存 [时间段] 数据
Future<http.Response> saveTimeLists(
    String uid,
    String name,
    String rdate,
    String rhourse,
    int notes,
    String userid,
    String username,
    int state) async {
  var url = Uri.parse(Application.servUrl + '/v1/timelist/updatetimelist');
  var post = {
    'uid': "${uid}",
    'name': "${name}",
    'rdate': "${rdate}",
    'rhourse': "${rhourse}",
    'notes': notes,
    'userid': "${userid}",
    'username': "${username}",
    'state': state,
  };
  var timelistbody = utf8.encode(json.encode(post));
  //print(timelistbody);
  var response = await http.post(url,
      headers: {"content-type": "application/json"}, body: timelistbody);

  //var body = response.body;
  //print("${response.statusCode}");
  //print("${response.body}");

  return response;
}

// delTimeList() - 删除 [时间段] 数据
Future<http.Response> delTimeList(String id) async {
  var response = await http
      .get(Uri.parse(Application.servUrl + '/v1/timelist/deltimelist/' + id));
  return response;
}
