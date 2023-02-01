import 'dart:convert';
/// status : true
/// data : {"items":"sad","add_on":"d"}
/// meassge : " Detail Updated successfully"

CreateTrackGeneralModel createTrackGeneralModelFromJson(String str) => CreateTrackGeneralModel.fromJson(json.decode(str));
String createTrackGeneralModelToJson(CreateTrackGeneralModel data) => json.encode(data.toJson());
class CreateTrackGeneralModel {
  CreateTrackGeneralModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateTrackGeneralModel.fromJson(dynamic json) {
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

/// items : "sad"
/// add_on : "d"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? items, 
      String? addOn,}){
    _items = items;
    _addOn = addOn;
}

  Data.fromJson(dynamic json) {
    _items = json['items'];
    _addOn = json['add_on'];
  }
  String? _items;
  String? _addOn;

  String? get items => _items;
  String? get addOn => _addOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['items'] = _items;
    map['add_on'] = _addOn;
    return map;
  }

}