class ShiftModel {
  int id;
  String title;
  String startTime;
  String endTime;
  int isSpecial;

  ShiftModel({this.id, this.title, this.startTime, this.endTime, this.isSpecial});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    isSpecial = json['is_special'] != null ? int.parse(json['is_special'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['is_special'] = this.isSpecial;
    return data;
  }
}
