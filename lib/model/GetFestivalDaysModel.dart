import 'dart:convert';
/// status : true
/// data : [{"id":"1","festival_id":"1","day_detail":"Cycling isn't just about raising your heart rate and getting you breathless - ","createt_at":"2022-02-23 09:19:09","status":"0"}]
/// meassge : "Listing  successfully"

GetFestivalDaysModel getFestivalDaysModelFromJson(String str) => GetFestivalDaysModel.fromJson(json.decode(str));
String getFestivalDaysModelToJson(GetFestivalDaysModel data) => json.encode(data.toJson());
class GetFestivalDaysModel {
  GetFestivalDaysModel({
      bool? status, 
      List<Data>? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  GetFestivalDaysModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _meassge = json['meassge'];
  }
  bool? _status;
  List<Data>? _data;
  String? _meassge;

  bool? get status => _status;
  List<Data>? get data => _data;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['meassge'] = _meassge;
    return map;
  }

}

/// id : "1"
/// festival_id : "1"
/// day_detail : "Cycling isn't just about raising your heart rate and getting you breathless - "
/// createt_at : "2022-02-23 09:19:09"
/// status : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? festivalId, 
      String? dayDetail, 
      String? createtAt, 
      String? status,}){
    _id = id;
    _festivalId = festivalId;
    _dayDetail = dayDetail;
    _createtAt = createtAt;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _festivalId = json['festival_id'];
    _dayDetail = json['day_detail'];
    _createtAt = json['createt_at'];
    _status = json['status'];
  }
  String? _id;
  String? _festivalId;
  String? _dayDetail;
  String? _createtAt;
  String? _status;

  String? get id => _id;
  String? get festivalId => _festivalId;
  String? get dayDetail => _dayDetail;
  String? get createtAt => _createtAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['festival_id'] = _festivalId;
    map['day_detail'] = _dayDetail;
    map['createt_at'] = _createtAt;
    map['status'] = _status;
    return map;
  }

}