class UserPod {
  String id;
  String username;
  String podname;
  String podip;
  String podstatus;
  int hostport;
  String podcpu;
  String podmemory;
  int createdtime;
  int lastuse;
  int role;
  bool isbanned;

  UserPod(
      {this.username,
      this.podname,
      this.podip,
      this.podstatus,
      this.hostport,
      this.podcpu,
      this.podmemory,
      this.createdtime,
      this.lastuse,
      this.role,
      this.isbanned});

  static UserPod map(Map map) => new UserPod()..fromMap(map);

  Map toJson() => {
        'id': id,
        'username': username,
        'podname': podname,
        'podip': podip,
        'podstatus': podstatus,
        'hostport': hostport,
        'podcpu': podcpu,
        'podmemory': podmemory,
        'createdtime': createdtime,
        'lastuse': lastuse,
        'role': role,
        'isbanned': isbanned,
      };

  UserPod.fromJson(Map<String, dynamic> json) {
    id = json['Uid'];
    username = json['Username'];
    podname = json['PodName'];
    podip = json['PodIp'];
    podstatus = json['PodStatus'];
    hostport = json['HostPort'];
    podcpu = json['PodCpu'];
    podmemory = json['PodMemory'];
    isbanned = json['IsBanned'];
    createdtime = json['CreatedTime'];
    lastuse = json['LastUse'];
    role = json['Role'];
  }

  void fromMap(Map map) => this
    ..id = map['id']
    ..username = map['username']
    ..podname = map['podname']
    ..podip = map['podip']
    ..podstatus = map['podstatus']
    ..hostport = map['hostport']
    ..podcpu = map['podcpu']
    ..podmemory = map['podmemory']
    ..isbanned = map['isbanned']
    ..createdtime = map['createdtime']
    ..lastuse = map['lastuse']
    ..role = map['role'];

  String toString() => toJson().toString();
}
