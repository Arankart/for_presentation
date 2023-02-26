class TimeDataModel {
  late int id;
  String? dataStart;
  String? dataEnd;

  TimeDataModel(this.id, this.dataStart, this.dataEnd);

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['dataStart'] = dataStart;
    map['dataEnd'] = dataEnd;
    return map;
  }

  TimeDataModel.fromMap(Map<String, dynamic> map) {
    dataStart = map['dataStart'];
    dataEnd = map['dataEnd'];
  }
}
