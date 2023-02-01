import 'dart:convert';
/// status : true
/// data : {"account_name":"sad","account_number":"asd","bank_name":"asd","ifsc_code":"asd","cancel_chaque":"1139037.jpg"}
/// meassge : "Account Detail Update successfully"

AddAccountModel addAccountModelFromJson(String str) => AddAccountModel.fromJson(json.decode(str));
String addAccountModelToJson(AddAccountModel data) => json.encode(data.toJson());
class AddAccountModel {
  AddAccountModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  AddAccountModel.fromJson(dynamic json) {
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

/// account_name : "sad"
/// account_number : "asd"
/// bank_name : "asd"
/// ifsc_code : "asd"
/// cancel_chaque : "1139037.jpg"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? accountName, 
      String? accountNumber, 
      String? bankName, 
      String? ifscCode, 
      String? cancelChaque,}){
    _accountName = accountName;
    _accountNumber = accountNumber;
    _bankName = bankName;
    _ifscCode = ifscCode;
    _cancelChaque = cancelChaque;
}

  Data.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
    _cancelChaque = json['cancel_chaque'];
  }
  String? _accountName;
  String? _accountNumber;
  String? _bankName;
  String? _ifscCode;
  String? _cancelChaque;

  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;
  String? get cancelChaque => _cancelChaque;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    map['cancel_chaque'] = _cancelChaque;
    return map;
  }

}