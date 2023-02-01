import 'dart:convert';
/// status : true
/// data : {"cycling_id":"1","brand_name":"Yamaha","no_of_bike":"3","rate":"240","type":"asddad","details":"asddasd","created_at":"2022-02-24 18:35:27"}
/// meassge : " Detail Added successfully"

CreateCycleBrandsModel createCycleBrandsModelFromJson(String str) => CreateCycleBrandsModel.fromJson(json.decode(str));
String createCycleBrandsModelToJson(CreateCycleBrandsModel data) => json.encode(data.toJson());
class CreateCycleBrandsModel {
  CreateCycleBrandsModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateCycleBrandsModel.fromJson(dynamic json) {
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

/// cycling_id : "1"
/// brand_name : "Yamaha"
/// no_of_bike : "3"
/// rate : "240"
/// type : "asddad"
/// details : "asddasd"
/// created_at : "2022-02-24 18:35:27"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? cyclingId, 
      String? brandName, 
      String? noOfBike, 
      String? rate, 
      String? type, 
      String? details, 
      String? createdAt,}){
    _cyclingId = cyclingId;
    _brandName = brandName;
    _noOfBike = noOfBike;
    _rate = rate;
    _type = type;
    _details = details;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _cyclingId = json['cycling_id'];
    _brandName = json['brand_name'];
    _noOfBike = json['no_of_bike'];
    _rate = json['rate'];
    _type = json['type'];
    _details = json['details'];
    _createdAt = json['created_at'];
  }
  String? _cyclingId;
  String? _brandName;
  String? _noOfBike;
  String? _rate;
  String? _type;
  String? _details;
  String? _createdAt;

  String? get cyclingId => _cyclingId;
  String? get brandName => _brandName;
  String? get noOfBike => _noOfBike;
  String? get rate => _rate;
  String? get type => _type;
  String? get details => _details;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cycling_id'] = _cyclingId;
    map['brand_name'] = _brandName;
    map['no_of_bike'] = _noOfBike;
    map['rate'] = _rate;
    map['type'] = _type;
    map['details'] = _details;
    map['created_at'] = _createdAt;
    return map;
  }

}