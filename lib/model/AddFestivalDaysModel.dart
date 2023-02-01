import 'dart:convert';
/// status : true
/// data : {"festival_id":"2","day_detail":"sdfdfdfsd","createt_at":"2022-02-25 02:37:06"}
/// meassge : " Detail Added successfully"

AddFestivalDaysModel addFestivalDaysModelFromJson(String str) => AddFestivalDaysModel.fromJson(json.decode(str));
String addFestivalDaysModelToJson(AddFestivalDaysModel data) => json.encode(data.toJson());
class AddFestivalDaysModel {
  AddFestivalDaysModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  AddFestivalDaysModel.fromJson(dynamic json) {
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

/// festival_id : "2"
/// day_detail : "sdfdfdfsd"
/// createt_at : "2022-02-25 02:37:06"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? festivalId, 
      String? dayDetail, 
      String? createtAt,}){
    _festivalId = festivalId;
    _dayDetail = dayDetail;
    _createtAt = createtAt;
}

  Data.fromJson(dynamic json) {
    _festivalId = json['festival_id'];
    _dayDetail = json['day_detail'];
    _createtAt = json['createt_at'];
  }
  String? _festivalId;
  String? _dayDetail;
  String? _createtAt;

  String? get festivalId => _festivalId;
  String? get dayDetail => _dayDetail;
  String? get createtAt => _createtAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['festival_id'] = _festivalId;
    map['day_detail'] = _dayDetail;
    map['createt_at'] = _createtAt;
    return map;
  }

}