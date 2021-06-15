import 'dart:convert';
import 'package:path/path.dart';
import 'dart:async';

class TimeList {
  String id;
  String name;
  String rdate;
  String rhourse;
  int notes;
  String userid;
  String username;
  int state;

  TimeList(
      {this.id,
      this.name,
      this.rdate,
      this.rhourse,
      this.notes,
      this.userid,
      this.username,
      this.state});

  static TimeList map(Map map) => new TimeList()..fromMap(map);

  Map toJson() => {
        'id': id,
        'name': name,
        'rdate': rdate,
        'rhourse': rhourse,
        'notes': notes,
        'userid': userid,
        'username': username,
        'state': state,
      };

  TimeList.fromJson(Map<String, dynamic> json) {
    id = json['UID'];
    name = json['Name'];
    rdate = json['Rdate'];
    rhourse = json['Rhourse'];
    notes = json['Notes'];
    userid = json['Userid'];
    username = json['Username'];
    state = json['State'];
  }

  void fromMap(Map map) => this
    ..id = map['UID']
    ..name = map['Name']
    ..rdate = map['Rdate']
    ..rhourse = map['Rhourse']
    ..notes = map['Notes']
    ..userid = map['Userid']
    ..username = map['Username']
    ..state = map['State'];

  String toString() => toJson().toString();
}

List<TimeList> allUsersFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<TimeList>.from(jsonData.map((x) => TimeList.fromJson(x)));
}

final TimeLists = <TimeList>[];

makeTimeListsTestData() {
  TimeLists.add(new TimeList(id: '1', name: 'test1'));
  TimeLists.add(new TimeList(id: '2', name: 'test2'));
}

printTimeLists() {
  print(TimeLists.toString());
}
