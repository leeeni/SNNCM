import 'dart:convert';
import 'package:path/path.dart';
import 'dart:async';

class Node {
  String id;
  String name;
  String ip;
  String describe;
  int cores;
  bool isonline;

  Node({this.id, this.name, this.ip, this.describe,this.cores,  this.isonline});

  static Node map(Map map) => new Node()..fromMap(map);

  Map toJson() => {
        'id': id,
        'name': name,
        'ip': ip,
        'cores': cores,
        'describe': describe,
        'isonline': isonline,
      };

  Node.fromJson(Map<String, dynamic> json) {
    id = json['UID'];
    name = json['Name'];
    ip = json['IP'];
    cores = json['Cores'];
    describe = json['Describe'];

  }

  void fromMap(Map map) => this
    ..id = map['id']
    ..name = map['name']
    ..ip = map['ip']
    ..cores = map['cores']
    ..describe = map['describe']
    ..isonline = map['isonline'];

  String toString() => toJson().toString();
}

List<Node> allUsersFromJson(String str) {
  final jsonData = json.decode(str);
  return new List<Node>.from(jsonData.map((x) => Node.fromJson(x)));
}

final nodes = <Node>[];
makeNodesTestData() {
  nodes.add(new Node(id: '1', name: 'test1'));
  nodes.add(new Node(id: '2', name: 'test2', ip: '202.116.130.1'));
}

printNodes() {
  print(nodes.toString());
}
