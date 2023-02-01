import 'dart:convert';
/// status : true
/// data : {"id":"10","user_id":"163","contact_name":"viex","contact_no":"6318","email_id":"gud","address":"vjwzbwx","day_no":"3","night_no":"2","track_start_point":"ve","track_end_point":"gdh","details":"vbd","inclusion":"hh","exclusion":"vhvvb","term_condition":"gh","rate_per_person":"ghh","items":"","add_on":"","account_name":"","account_no":"","bank_name":"","ifsc_code":"","chaque_image":"","status":"0","createt_at":"2022-02-24 12:13:07"}
/// meassge : " Detail Added successfully"

CreateTrackModel createTrackModelFromJson(String str) => CreateTrackModel.fromJson(json.decode(str));
String createTrackModelToJson(CreateTrackModel data) => json.encode(data.toJson());
class CreateTrackModel {
  CreateTrackModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateTrackModel.fromJson(dynamic json) {
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

/// id : "10"
/// user_id : "163"
/// contact_name : "viex"
/// contact_no : "6318"
/// email_id : "gud"
/// address : "vjwzbwx"
/// day_no : "3"
/// night_no : "2"
/// track_start_point : "ve"
/// track_end_point : "gdh"
/// details : "vbd"
/// inclusion : "hh"
/// exclusion : "vhvvb"
/// term_condition : "gh"
/// rate_per_person : "ghh"
/// items : ""
/// add_on : ""
/// account_name : ""
/// account_no : ""
/// bank_name : ""
/// ifsc_code : ""
/// chaque_image : ""
/// status : "0"
/// createt_at : "2022-02-24 12:13:07"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? contactName, 
      String? contactNo, 
      String? emailId, 
      String? address, 
      String? dayNo, 
      String? nightNo, 
      String? trackStartPoint, 
      String? trackEndPoint, 
      String? details, 
      String? inclusion, 
      String? exclusion, 
      String? termCondition, 
      String? ratePerPerson, 
      String? items, 
      String? addOn, 
      String? accountName, 
      String? accountNo, 
      String? bankName, 
      String? ifscCode, 
      String? chaqueImage, 
      String? status, 
      String? createtAt,}){
    _id = id;
    _userId = userId;
    _contactName = contactName;
    _contactNo = contactNo;
    _emailId = emailId;
    _address = address;
    _dayNo = dayNo;
    _nightNo = nightNo;
    _trackStartPoint = trackStartPoint;
    _trackEndPoint = trackEndPoint;
    _details = details;
    _inclusion = inclusion;
    _exclusion = exclusion;
    _termCondition = termCondition;
    _ratePerPerson = ratePerPerson;
    _items = items;
    _addOn = addOn;
    _accountName = accountName;
    _accountNo = accountNo;
    _bankName = bankName;
    _ifscCode = ifscCode;
    _chaqueImage = chaqueImage;
    _status = status;
    _createtAt = createtAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _contactName = json['contact_name'];
    _contactNo = json['contact_no'];
    _emailId = json['email_id'];
    _address = json['address'];
    _dayNo = json['day_no'];
    _nightNo = json['night_no'];
    _trackStartPoint = json['track_start_point'];
    _trackEndPoint = json['track_end_point'];
    _details = json['details'];
    _inclusion = json['inclusion'];
    _exclusion = json['exclusion'];
    _termCondition = json['term_condition'];
    _ratePerPerson = json['rate_per_person'];
    _items = json['items'];
    _addOn = json['add_on'];
    _accountName = json['account_name'];
    _accountNo = json['account_no'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
    _chaqueImage = json['chaque_image'];
    _status = json['status'];
    _createtAt = json['createt_at'];
  }
  String? _id;
  String? _userId;
  String? _contactName;
  String? _contactNo;
  String? _emailId;
  String? _address;
  String? _dayNo;
  String? _nightNo;
  String? _trackStartPoint;
  String? _trackEndPoint;
  String? _details;
  String? _inclusion;
  String? _exclusion;
  String? _termCondition;
  String? _ratePerPerson;
  String? _items;
  String? _addOn;
  String? _accountName;
  String? _accountNo;
  String? _bankName;
  String? _ifscCode;
  String? _chaqueImage;
  String? _status;
  String? _createtAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get contactName => _contactName;
  String? get contactNo => _contactNo;
  String? get emailId => _emailId;
  String? get address => _address;
  String? get dayNo => _dayNo;
  String? get nightNo => _nightNo;
  String? get trackStartPoint => _trackStartPoint;
  String? get trackEndPoint => _trackEndPoint;
  String? get details => _details;
  String? get inclusion => _inclusion;
  String? get exclusion => _exclusion;
  String? get termCondition => _termCondition;
  String? get ratePerPerson => _ratePerPerson;
  String? get items => _items;
  String? get addOn => _addOn;
  String? get accountName => _accountName;
  String? get accountNo => _accountNo;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;
  String? get chaqueImage => _chaqueImage;
  String? get status => _status;
  String? get createtAt => _createtAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['contact_name'] = _contactName;
    map['contact_no'] = _contactNo;
    map['email_id'] = _emailId;
    map['address'] = _address;
    map['day_no'] = _dayNo;
    map['night_no'] = _nightNo;
    map['track_start_point'] = _trackStartPoint;
    map['track_end_point'] = _trackEndPoint;
    map['details'] = _details;
    map['inclusion'] = _inclusion;
    map['exclusion'] = _exclusion;
    map['term_condition'] = _termCondition;
    map['rate_per_person'] = _ratePerPerson;
    map['items'] = _items;
    map['add_on'] = _addOn;
    map['account_name'] = _accountName;
    map['account_no'] = _accountNo;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    map['chaque_image'] = _chaqueImage;
    map['status'] = _status;
    map['createt_at'] = _createtAt;
    return map;
  }

}