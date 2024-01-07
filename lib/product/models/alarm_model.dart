import '../../core/init/database/database_model.dart';

class AlarmModel extends DatabaseModel<AlarmModel> {
  int? id;
  DateTime? dateTime;
  String? title;

  AlarmModel({
    this.id,
    this.dateTime,
    this.title,
  });

  AlarmModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateTime =
        json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null;
    title = json['title'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['dateTime'] =
        dateTime?.toIso8601String(); // Convert DateTime to string
    data['title'] = title;
    return data;
  }

  @override
  AlarmModel fromJson(Map<String, dynamic> json) {
    return AlarmModel.fromJson(json);
  }
}
