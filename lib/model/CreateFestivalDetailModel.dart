import 'dart:convert';
/// status : true
/// data : {"id":"2","user_id":"1","activity_name":" CYCLING IMPROVES MENTAL WELL-BEING","contact_name":"rahul baba","contact_no":"7895258965","email_id":"rahulbaba@gmail.com","address":"The Ambury, Bath BA1 1UA. All rights reserved. England and Wales company registration number 2008885.","no_of_day":"5","brief_overview":"Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves.","things_carry":"","inclusion":"Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves.","exclusion":"Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves.","term_condition":"Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves.","account_name":"","account_no":"","bank_name":"","ifsc_code":"","created_at":"2022-02-25 01:48:32","status":"0"}
/// meassge : " Detail Added successfully"

CreateFestivalDetailModel createFestivalDetailModelFromJson(String str) => CreateFestivalDetailModel.fromJson(json.decode(str));
String createFestivalDetailModelToJson(CreateFestivalDetailModel data) => json.encode(data.toJson());
class CreateFestivalDetailModel {
  CreateFestivalDetailModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateFestivalDetailModel.fromJson(dynamic json) {
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

/// id : "2"
/// user_id : "1"
/// activity_name : " CYCLING IMPROVES MENTAL WELL-BEING"
/// contact_name : "rahul baba"
/// contact_no : "7895258965"
/// email_id : "rahulbaba@gmail.com"
/// address : "The Ambury, Bath BA1 1UA. All rights reserved. England and Wales company registration number 2008885."
/// no_of_day : "5"
/// brief_overview : "Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves."
/// things_carry : ""
/// inclusion : "Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves."
/// exclusion : "Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves."
/// term_condition : "Cycling isn't just about raising your heart rate and getting you breathless - unless you're doing it on Zwift. There are technical elements - climbing, descending and cornering all teach you to use your body weight to get the bike to go where you want it to.\n\nGaining the skills to manage these technical elements can provide a massive confidence boost - especially when you start to see improvement. Plus, you might just find your abilities to manage that dodgy shopping trolley with the wonky wheels greatly improves."
/// account_name : ""
/// account_no : ""
/// bank_name : ""
/// ifsc_code : ""
/// created_at : "2022-02-25 01:48:32"
/// status : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? userId, 
      String? activityName, 
      String? contactName, 
      String? contactNo, 
      String? emailId, 
      String? address, 
      String? noOfDay, 
      String? briefOverview, 
      String? thingsCarry, 
      String? inclusion, 
      String? exclusion, 
      String? termCondition, 
      String? accountName, 
      String? accountNo, 
      String? bankName, 
      String? ifscCode, 
      String? createdAt, 
      String? status,}){
    _id = id;
    _userId = userId;
    _activityName = activityName;
    _contactName = contactName;
    _contactNo = contactNo;
    _emailId = emailId;
    _address = address;
    _noOfDay = noOfDay;
    _briefOverview = briefOverview;
    _thingsCarry = thingsCarry;
    _inclusion = inclusion;
    _exclusion = exclusion;
    _termCondition = termCondition;
    _accountName = accountName;
    _accountNo = accountNo;
    _bankName = bankName;
    _ifscCode = ifscCode;
    _createdAt = createdAt;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _activityName = json['activity_name'];
    _contactName = json['contact_name'];
    _contactNo = json['contact_no'];
    _emailId = json['email_id'];
    _address = json['address'];
    _noOfDay = json['no_of_day'];
    _briefOverview = json['brief_overview'];
    _thingsCarry = json['things_carry'];
    _inclusion = json['inclusion'];
    _exclusion = json['exclusion'];
    _termCondition = json['term_condition'];
    _accountName = json['account_name'];
    _accountNo = json['account_no'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }
  String? _id;
  String? _userId;
  String? _activityName;
  String? _contactName;
  String? _contactNo;
  String? _emailId;
  String? _address;
  String? _noOfDay;
  String? _briefOverview;
  String? _thingsCarry;
  String? _inclusion;
  String? _exclusion;
  String? _termCondition;
  String? _accountName;
  String? _accountNo;
  String? _bankName;
  String? _ifscCode;
  String? _createdAt;
  String? _status;

  String? get id => _id;
  String? get userId => _userId;
  String? get activityName => _activityName;
  String? get contactName => _contactName;
  String? get contactNo => _contactNo;
  String? get emailId => _emailId;
  String? get address => _address;
  String? get noOfDay => _noOfDay;
  String? get briefOverview => _briefOverview;
  String? get thingsCarry => _thingsCarry;
  String? get inclusion => _inclusion;
  String? get exclusion => _exclusion;
  String? get termCondition => _termCondition;
  String? get accountName => _accountName;
  String? get accountNo => _accountNo;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['activity_name'] = _activityName;
    map['contact_name'] = _contactName;
    map['contact_no'] = _contactNo;
    map['email_id'] = _emailId;
    map['address'] = _address;
    map['no_of_day'] = _noOfDay;
    map['brief_overview'] = _briefOverview;
    map['things_carry'] = _thingsCarry;
    map['inclusion'] = _inclusion;
    map['exclusion'] = _exclusion;
    map['term_condition'] = _termCondition;
    map['account_name'] = _accountName;
    map['account_no'] = _accountNo;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    return map;
  }

}