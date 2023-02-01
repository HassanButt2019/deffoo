import 'dart:convert';
/// status : true
/// data : [{"id":"1","host_id":"163","title":"demo","contact":"7049202366","email":"dminj22@gmail.com","address":"dminj22@gmail.com","type":"1","type_name":"Flats","check_in":"08:38:00","check_out":"22:38:00","internet":"[Wifi, VI, Jio]","others":"[Laptop charging point, Fan, Swimming pool, Garden/lawn, Pet allowed]","bedroom":"[Medium, Double]","tv":"[USB, Cable]","room_heater":"[]","toilet":"[]","hot_drinking":"[]","no_of_room":"14","description":"gdjdbddkdbsjsjs","account_name":"","account_number":"","bank_name":"","ifsc_code":"","cancel_chaque":"","created_at":"0000-00-00 00:00:00","status":"0"}]
/// meassge : "Listing Update successfully"

SearchPropertyModel searchPropertyModelFromJson(String str) => SearchPropertyModel.fromJson(json.decode(str));
String searchPropertyModelToJson(SearchPropertyModel data) => json.encode(data.toJson());
class SearchPropertyModel {
  SearchPropertyModel({
      bool? status, 
      List<Data>? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  SearchPropertyModel.fromJson(dynamic json) {
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

/// id : "1"
/// host_id : "163"
/// title : "demo"
/// contact : "7049202366"
/// email : "dminj22@gmail.com"
/// address : "dminj22@gmail.com"
/// type : "1"
/// type_name : "Flats"
/// check_in : "08:38:00"
/// check_out : "22:38:00"
/// internet : "[Wifi, VI, Jio]"
/// others : "[Laptop charging point, Fan, Swimming pool, Garden/lawn, Pet allowed]"
/// bedroom : "[Medium, Double]"
/// tv : "[USB, Cable]"
/// room_heater : "[]"
/// toilet : "[]"
/// hot_drinking : "[]"
/// no_of_room : "14"
/// description : "gdjdbddkdbsjsjs"
/// account_name : ""
/// account_number : ""
/// bank_name : ""
/// ifsc_code : ""
/// cancel_chaque : ""
/// created_at : "0000-00-00 00:00:00"
/// status : "0"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? hostId, 
      String? title, 
      String? contact, 
      String? email, 
      String? address, 
      String? type, 
      String? typeName, 
      String? checkIn, 
      String? checkOut, 
      String? internet, 
      String? others, 
      String? bedroom, 
      String? tv, 
      String? roomHeater, 
      String? toilet, 
      String? hotDrinking, 
      String? noOfRoom, 
      String? description, 
      String? accountName, 
      String? accountNumber, 
      String? bankName, 
      String? ifscCode, 
      String? cancelChaque, 
      String? createdAt, 
      String? status,}){
    _id = id;
    _hostId = hostId;
    _title = title;
    _contact = contact;
    _email = email;
    _address = address;
    _type = type;
    _typeName = typeName;
    _checkIn = checkIn;
    _checkOut = checkOut;
    _internet = internet;
    _others = others;
    _bedroom = bedroom;
    _tv = tv;
    _roomHeater = roomHeater;
    _toilet = toilet;
    _hotDrinking = hotDrinking;
    _noOfRoom = noOfRoom;
    _description = description;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _bankName = bankName;
    _ifscCode = ifscCode;
    _cancelChaque = cancelChaque;
    _createdAt = createdAt;
    _status = status;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _hostId = json['host_id'];
    _title = json['title'];
    _contact = json['contact'];
    _email = json['email'];
    _address = json['address'];
    _type = json['type'];
    _typeName = json['type_name'];
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
    _internet = json['internet'];
    _others = json['others'];
    _bedroom = json['bedroom'];
    _tv = json['tv'];
    _roomHeater = json['room_heater'];
    _toilet = json['toilet'];
    _hotDrinking = json['hot_drinking'];
    _noOfRoom = json['no_of_room'];
    _description = json['description'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _bankName = json['bank_name'];
    _ifscCode = json['ifsc_code'];
    _cancelChaque = json['cancel_chaque'];
    _createdAt = json['created_at'];
    _status = json['status'];
  }
  String? _id;
  String? _hostId;
  String? _title;
  String? _contact;
  String? _email;
  String? _address;
  String? _type;
  String? _typeName;
  String? _checkIn;
  String? _checkOut;
  String? _internet;
  String? _others;
  String? _bedroom;
  String? _tv;
  String? _roomHeater;
  String? _toilet;
  String? _hotDrinking;
  String? _noOfRoom;
  String? _description;
  String? _accountName;
  String? _accountNumber;
  String? _bankName;
  String? _ifscCode;
  String? _cancelChaque;
  String? _createdAt;
  String? _status;

  String? get id => _id;
  String? get hostId => _hostId;
  String? get title => _title;
  String? get contact => _contact;
  String? get email => _email;
  String? get address => _address;
  String? get type => _type;
  String? get typeName => _typeName;
  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  String? get internet => _internet;
  String? get others => _others;
  String? get bedroom => _bedroom;
  String? get tv => _tv;
  String? get roomHeater => _roomHeater;
  String? get toilet => _toilet;
  String? get hotDrinking => _hotDrinking;
  String? get noOfRoom => _noOfRoom;
  String? get description => _description;
  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get bankName => _bankName;
  String? get ifscCode => _ifscCode;
  String? get cancelChaque => _cancelChaque;
  String? get createdAt => _createdAt;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['host_id'] = _hostId;
    map['title'] = _title;
    map['contact'] = _contact;
    map['email'] = _email;
    map['address'] = _address;
    map['type'] = _type;
    map['type_name'] = _typeName;
    map['check_in'] = _checkIn;
    map['check_out'] = _checkOut;
    map['internet'] = _internet;
    map['others'] = _others;
    map['bedroom'] = _bedroom;
    map['tv'] = _tv;
    map['room_heater'] = _roomHeater;
    map['toilet'] = _toilet;
    map['hot_drinking'] = _hotDrinking;
    map['no_of_room'] = _noOfRoom;
    map['description'] = _description;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['bank_name'] = _bankName;
    map['ifsc_code'] = _ifscCode;
    map['cancel_chaque'] = _cancelChaque;
    map['created_at'] = _createdAt;
    map['status'] = _status;
    return map;
  }

}