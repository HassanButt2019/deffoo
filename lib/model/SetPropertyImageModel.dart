import 'dart:convert';
/// status : true
/// data : {"property_image":"1139048.jpg","property_id":"1","created_at":"2022-02-12 11:27:23"}
/// meassge : "Gallery Upload successfully"

SetPropertyImageModel setPropertyImageModelFromJson(String str) => SetPropertyImageModel.fromJson(json.decode(str));
String setPropertyImageModelToJson(SetPropertyImageModel data) => json.encode(data.toJson());
class SetPropertyImageModel {
  SetPropertyImageModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  SetPropertyImageModel.fromJson(dynamic json) {
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

/// property_image : "1139048.jpg"
/// property_id : "1"
/// created_at : "2022-02-12 11:27:23"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? propertyImage, 
      String? propertyId, 
      String? createdAt,}){
    _propertyImage = propertyImage;
    _propertyId = propertyId;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _propertyImage = json['property_image'];
    _propertyId = json['property_id'];
    _createdAt = json['created_at'];
  }
  String? _propertyImage;
  String? _propertyId;
  String? _createdAt;

  String? get propertyImage => _propertyImage;
  String? get propertyId => _propertyId;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property_image'] = _propertyImage;
    map['property_id'] = _propertyId;
    map['created_at'] = _createdAt;
    return map;
  }

}