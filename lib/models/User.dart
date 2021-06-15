class User {
  String id;
  String username;
  String password;
  bool rolesys;
  bool roleadmin;
  int state;

  User(
      {this.username, this.password, this.rolesys, this.roleadmin, this.state});

  static User map(Map map) => new User()..fromMap(map);

  Map toJson() => {
        'id': id,
        'name': username,
        'password': password,
        'rolesys': rolesys,
        'roleadmin': roleadmin,
        'state': state,
      };

  User.fromJson(Map<String, dynamic> json) {
    id = json['UID'];
    username = json['Username'];
    password = json['Password'];
    rolesys = json['RoleSys'];
    roleadmin = json['RoleAdmin'];
    state = json['State'];
  }

  void fromMap(Map map) => this
    ..id = map['id']
    ..username = map['username']
    ..password = map['password']
    ..rolesys = map['rolesys']
    ..roleadmin = map['roleadmin']
    ..state = map['state'];

  String toString() => toJson().toString();
}
