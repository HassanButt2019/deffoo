import 'dart:convert';
/// status : true
/// data : {"things_carry":"1"}
/// meassge : " Detail Updated successfully"

CreateFestivalThingsModel createFestivalThingsModelFromJson(String str) => CreateFestivalThingsModel.fromJson(json.decode(str));
String createFestivalThingsModelToJson(CreateFestivalThingsModel data) => json.encode(data.toJson());
class CreateFestivalThingsModel {
  CreateFestivalThingsModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateFestivalThingsModel.fromJson(dynamic json) {
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

/// things_carry : "1"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? thingsCarry,}){
    _thingsCarry = thingsCarry;
}

  Data.fromJson(dynamic json) {
    _thingsCarry = json['things_carry'];
  }
  String? _thingsCarry;

  String? get thingsCarry => _thingsCarry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['things_carry'] = _thingsCarry;
    return map;
  }

}