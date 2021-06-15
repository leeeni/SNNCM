class MonitorData {
  String host;
  double cpu;
  double mem;

  MonitorData({this.host, this.cpu, this.mem});

  fromJsonCpu(Map<String, dynamic> json) {
    host = json['Host'];
    cpu = json['CPUPerc'];
  }

  fromJsonMem(Map<String, dynamic> json) {
    host = json['Host'];
    mem = json['MemPerc'];
  }
}
