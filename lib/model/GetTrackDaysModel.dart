import 'dart:convert';
/// status : true
/// data : [{"id":"1","track_id":"2","day_detail":"Kids in Parks Goes Coast to Coast!\\nSince the start of Kids in Parks in 2009","image":"","createt_at":"2022-02-22 13:46:11","status":"0"},{"id":"2","track_id":"2","day_detail":"dasdasdsad","image":"","createt_at":"2022-02-24 13:02:41","status":"0"}]
/// meassge : "Listing  successfully"
/// path : "https://alphawizztest.tk/Deffo/uploads/track_img"

GetTrackDaysModel getTrackDaysModelFromJson(String str) => GetTrackDaysModel.fromJson(json.decode(str));
String getTrackDaysModelToJson(GetTrackDaysModel data) => json.encode(data.toJson());
class GetTrackDaysModel {
  GetTrackDaysModel({
      bool? status, 
      List<Data>? data, 
      String? meassge, 
      String? path,}){
    _status = status;
    _data = data;
    _meassge = meassge;
    _path = path;
}

  GetTrackDaysModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _meassge = json['meassge'];
    _path = json['path'];
  }
  bool? _status;
  List<Data>? _data;
  String? _meassge;
  String? _path;

  bool? get status => _status;
  List<Data>? get data => _data;
  String? get meassge => _meassge;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['meassge'] = _meassge;
    map['path'] = _path;
    return map;
  }

}

/// id : "1"
/// track_id : "2"
/// day_detail : "Kids in Parks Goes Coast to Coast!\\nSince the start of Kids in Parks in 2009"
/// image : ""
/// createt_at : "2022-02-22 13:46:11"
/// status : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? trackId, 
      String? dayDetail, 
      String? image, 
      String? createtAt, 
      String? status,}){
    _id = id;
    _trackId = trackId;
    _dayDetail = dayDetail;
    _image = image;
    _createtAt = createtAt;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _trackId = json['track_id'];
    _dayDetail = json['day_detail'];
    _image = json['image'];
    _createtAt = json['createt_at'];
    _status = json['status'];
  }
  String? _id;
  String? _trackId;
  String? _dayDetail;
  String? _image;
  String? _createtAt;
  String? _status;

  String? get id => _id;
  String? get trackId => _trackId;
  String? get dayDetail => _dayDetail;
  String? get image => _image;
  String? get createtAt => _createtAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['track_id'] = _trackId;
    map['day_detail'] = _dayDetail;
    map['image'] = _image;
    map['createt_at'] = _createtAt;
    map['status'] = _status;
    return map;
  }

}