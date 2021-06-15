class Task {
  String id;
  String taskid;
  String name;
  String describe;

  Task({this.taskid, this.name, this.describe});

  static Task map(Map map) => new Task()..fromMap(map);

  Map toJson() => {
        'id': id,
        'taskid': taskid,
        'name': name,
        'describe': describe,
      };

  Task.fromJson(Map<String, dynamic> json) {
    id = json['UID'];
    taskid = json['TaskID'];
    name = json['Name'];
    describe = json['Describe'];
    //regdate = json['CreatedTime'];
    //admin = json['Role'];
  }

  void fromMap(Map map) => this
    ..id = map['id']
    ..taskid = map['taskid']
    ..name = map['username']
    ..describe = map['describe'];

  String toString() => toJson().toString();
}
