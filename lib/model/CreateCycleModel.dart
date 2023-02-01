import 'dart:convert';
/// status : true
/// data : {"id":"6","user_id":"163","activity_name":"cycle","contact_no":"7049202363","contact_name":"Deepak","email_id":"dminj22@gmail.com","address":"bdjdbdjd","no_of_bikes":"2","brief_overview":" zbzb","inclusion":"vsvdv","exclusion":"bdbdb","term_condition":"gdgxgdg","account_no":"","account_name":"","bank_name":"","ifsc_code":"","status":"0","created_at":"2022-02-24 18:26:20"}
/// meassge : " Detail Added successfully"

CreateCycleModel createCycleModelFromJson(String str) => CreateCycleModel.fromJson(json.decode(str));
String createCycleModelToJson(CreateCycleModel data) => json.encode(data.toJson());
class CreateCycleModel {
  CreateCycleModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateCycleModel.fromJson(dynamic json) {
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

/// id : "6"
/// user_id : "163"
/// activity_name : "cycle"
/// contact_no : "7049202363"
/// contact_name : "Deepak"
/// email_id : "dminj22@gmail.com"
/// address : "bdjdbdjd"
/// no_of_bikes : "2"
/// brief_overview : " zbzb"
/// inclusion : "vsvdv"
/// exclusion : "bdbdb"
/// term_condition : "gdgxgdg"
/// account_no : ""
/// account_name : ""
/// bank_name : ""
/// ifsc_code : ""
/// status : "0"
/// created_at : "2022-02-24 18:26:20"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? activityName, 
      String? contactNo, 
      String? contactName, 
      String? emailId, 
      String? address, 
      String? noOfBikes, 
      String? briefOverview, 
      String? inclusion, 
      String? exclusion, 
      String? termCondition, 
      String? accountNo, 
      String? accountName, 
      String? bankName, 
      String? ifscCode, 
      String? status, 
      String? createdAt,}){
    _id = id;
    _userId = userId;
    _activityName = activityName;
    _contactNo = contactNo;
    _contactName = contactName;
    _emailId = emailId;
    _address = address;
    _noOfBikes = noOfBikes;
    _briefOverview = briefOverview;
    _inclusion = inclusion;
    _exclusion = exclusion;
    _termCondition = termCondition;
    _accountNo = accountNo;
    _accountName = accountName;
    _bankName = bankName;
    _ifscCode = ifscCode;
    _status = status;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _activityName = json['activity_name'];
    _contactNo = json['contact_no'];
    _contactName = json['contact_name'];
    _emailId = json['email_id'];
    _address = json['address'];
    _noOfBikes = json['no_of_bikes'];
    _briefOverview = json['brief_overview'];
    _inclusion = json['inclusion'];
    _exclusion = json['exclusion'];
    _termCondition = json['term_condition'];
    _accountNo = json['account_no'];
    _accountName = json['account_name'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
    _status = json['status'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _userId;
  String? _activityName;
  String? _contactNo;
  String? _contactName;
  String? _emailId;
  String? _address;
  String? _noOfBikes;
  String? _briefOverview;
  String? _inclusion;
  String? _exclusion;
  String? _termCondition;
  String? _accountNo;
  String? _accountName;
  String? _bankName;
  String? _ifscCode;
  String? _status;
  String? _createdAt;

  String? get id => _id;
  String? get userId => _userId;
  String? get activityName => _activityName;
  String? get contactNo => _contactNo;
  String? get contactName => _contactName;
  String? get emailId => _emailId;
  String? get address => _address;
  String? get noOfBikes => _noOfBikes;
  String? get briefOverview => _briefOverview;
  String? get inclusion => _inclusion;
  String? get exclusion => _exclusion;
  String? get termCondition => _termCondition;
  String? get accountNo => _accountNo;
  String? get accountName => _accountName;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;
  String? get status => _status;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['activity_name'] = _activityName;
    map['contact_no'] = _contactNo;
    map['contact_name'] = _contactName;
    map['email_id'] = _emailId;
    map['address'] = _address;
    map['no_of_bikes'] = _noOfBikes;
    map['brief_overview'] = _briefOverview;
    map['inclusion'] = _inclusion;
    map['exclusion'] = _exclusion;
    map['term_condition'] = _termCondition;
    map['account_no'] = _accountNo;
    map['account_name'] = _accountName;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    return map;
  }

}