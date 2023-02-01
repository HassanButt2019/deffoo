import 'dart:convert';
/// status : true
/// data : {"track_id":"2","day_detail":"dasdasdsad","createt_at":"2022-02-24 13:02:41"}
/// meassge : " Detail Added successfully"

CreateTrackDayModel createTrackDayModelFromJson(String str) => CreateTrackDayModel.fromJson(json.decode(str));
String createTrackDayModelToJson(CreateTrackDayModel data) => json.encode(data.toJson());
class CreateTrackDayModel {
  CreateTrackDayModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateTrackDayModel.fromJson(dynamic json) {
    _status = json['status'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _meassge = json['meassge'];
  }
  bool? _status;
  Data? _data;
  String? _meassge;

  bool? get status => _status;
  Data? get data => _data;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['meassge'] = _meassge;
    return map;
  }

}

/// track_id : "2"
/// day_detail : "dasdasdsad"
/// createt_at : "2022-02-24 13:02:41"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? trackId, 
      String? dayDetail, 
      String? createtAt,}){
    _trackId = trackId;
    _dayDetail = dayDetail;
    _createtAt = createtAt;
}

  Data.fromJson(dynamic json) {
    _trackId = json['track_id'];
    _dayDetail = json['day_detail'];
    _createtAt = json['createt_at'];
  }
  String? _trackId;
  String? _dayDetail;
  String? _createtAt;

  String? get trackId => _trackId;
  String? get dayDetail => _dayDetail;
  String? get createtAt => _createtAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['track_id'] = _trackId;
    map['day_detail'] = _dayDetail;
    map['createt_at'] = _createtAt;
    return map;
  }

}