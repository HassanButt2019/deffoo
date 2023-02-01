import 'dart:convert';
/// status : true
/// data : [{"id":"2","cycling_id":"1","brand_name":"Yamaha","no_of_bike":"3","rate":"240","type":"asddad","details":"asddasd","created_at":"2022-02-24 18:35:27","status":"0"}]
/// meassge : "Listing  successfully"

GetCycleBrandsModel getCycleBrandsModelFromJson(String str) => GetCycleBrandsModel.fromJson(json.decode(str));
String getCycleBrandsModelToJson(GetCycleBrandsModel data) => json.encode(data.toJson());
class GetCycleBrandsModel {
  GetCycleBrandsModel({
      bool? status, 
      List<Data>? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  GetCycleBrandsModel.fromJson(dynamic json) {
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

/// id : "2"
/// cycling_id : "1"
/// brand_name : "Yamaha"
/// no_of_bike : "3"
/// rate : "240"
/// type : "asddad"
/// details : "asddasd"
/// created_at : "2022-02-24 18:35:27"
/// status : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? cyclingId, 
      String? brandName, 
      String? noOfBike, 
      String? rate, 
      String? type, 
      String? details, 
      String? createdAt, 
      String? status,}){
    _id = id;
    _cyclingId = cyclingId;
    _brandName = brandName;
    _noOfBike = noOfBike;
    _rate = rate;
    _type = type;
    _details = details;
    _createdAt = createdAt;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cyclingId = json['cycling_id'];
    _brandName = json['brand_name'];
    _noOfBike = json['no_of_bike'];
    _rate = json['rate'];
    _type = json['type'];
    _details = json['details'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }
  String? _id;
  String? _cyclingId;
  String? _brandName;
  String? _noOfBike;
  String? _rate;
  String? _type;
  String? _details;
  String? _createdAt;
  String? _status;

  String? get id => _id;
  String? get cyclingId => _cyclingId;
  String? get brandName => _brandName;
  String? get noOfBike => _noOfBike;
  String? get rate => _rate;
  String? get type => _type;
  String? get details => _details;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cycling_id'] = _cyclingId;
    map['brand_name'] = _brandName;
    map['no_of_bike'] = _noOfBike;
    map['rate'] = _rate;
    map['type'] = _type;
    map['details'] = _details;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    return map;
  }

}