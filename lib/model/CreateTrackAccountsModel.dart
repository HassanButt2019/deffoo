import 'dart:convert';
/// status : true
/// data : {"account_name":"","account_no":"","bank_name":"","ifsc_code":""}
/// meassge : " Detail Updated successfully"

CreateTrackAccountsModel createTrackAccountsModelFromJson(String str) => CreateTrackAccountsModel.fromJson(json.decode(str));
String createTrackAccountsModelToJson(CreateTrackAccountsModel data) => json.encode(data.toJson());
class CreateTrackAccountsModel {
  CreateTrackAccountsModel({
      bool? status, 
      Data? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  CreateTrackAccountsModel.fromJson(dynamic json) {
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

/// account_name : ""
/// account_no : ""
/// bank_name : ""
/// ifsc_code : ""

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? accountName, 
      String? accountNo, 
      String? bankName, 
      String? ifscCode,}){
    _accountName = accountName;
    _accountNo = accountNo;
    _bankName = bankName;
    _ifscCode = ifscCode;
}

  Data.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _accountNo = json['account_no'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
  }
  String? _accountName;
  String? _accountNo;
  String? _bankName;
  String? _ifscCode;

  String? get accountName => _accountName;
  String? get accountNo => _accountNo;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['account_no'] = _accountNo;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    return map;
  }

}