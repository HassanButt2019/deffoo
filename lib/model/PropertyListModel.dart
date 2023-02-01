import 'dart:convert';
/// status : true
/// data : [{"id":"19","host_id":"163","title":"Demo","contact_name":"Demo","contact":"7049202363","email":"dmin@gmail.com","address":"demo address","type":"1","type_name":"Homestay","check_in":"10:20:00","check_out":"15:30:00","internet":"","others":"","room_type":"","room_type_name":"","rent_room":"","bedroom":"","tv":"","room_heater":"","toilet":"","hot_drinking":"","no_of_room":"0","description":"sadsdsa","account_name":"","account_number":"","bank_name":"","ifsc_code":"","cancel_chaque":"","created_at":"0000-00-00 00:00:00","status":"0"}]
/// meassge : "Listing Update successfully"

PropertyListModel propertyListModelFromJson(String str) => PropertyListModel.fromJson(json.decode(str));
String propertyListModelToJson(PropertyListModel data) => json.encode(data.toJson());
class PropertyListModel {
  PropertyListModel({
      bool? status, 
      List<Data>? data, 
      String? meassge,}){
    _status = status;
    _data = data;
    _meassge = meassge;
}

  PropertyListModel.fromJson(dynamic json) {
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

/// id : "19"
/// host_id : "163"
/// title : "Demo"
/// contact_name : "Demo"
/// contact : "7049202363"
/// email : "dmin@gmail.com"
/// address : "demo address"
/// type : "1"
/// type_name : "Homestay"
/// check_in : "10:20:00"
/// check_out : "15:30:00"
/// internet : ""
/// others : ""
/// room_type : ""
/// room_type_name : ""
/// rent_room : ""
/// bedroom : ""
/// tv : ""
/// room_heater : ""
/// toilet : ""
/// hot_drinking : ""
/// no_of_room : "0"
/// description : "sadsdsa"
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
    String? city_id,
    String? hostId,
      String? title, 
      String? contactName, 
      String? contact, 
      String? email, 
      String? address, 
      String? type, 
      String? typeName, 
      String? checkIn, 
      String? checkOut, 
      String? internet, 
      String? others, 
      String? roomType, 
      String? roomTypeName, 
      String? rentRoom, 
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
    _city_id = city_id;
    _hostId = hostId;
    _title = title;
    _contactName = contactName;
    _contact = contact;
    _email = email;
    _address = address;
    _type = type;
    _typeName = typeName;
    _checkIn = checkIn;
    _checkOut = checkOut;
    _internet = internet;
    _others = others;
    _roomType = roomType;
    _roomTypeName = roomTypeName;
    _rentRoom = rentRoom;
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
    _city_id = json['city_id'];
    _hostId = json['host_id'];
    _title = json['title'];
    _contactName = json['contact_name'];
    _contact = json['contact'];
    _email = json['email'];
    _address = json['address'];
    _type = json['type'];
    _typeName = json['type_name'];
    _checkIn = json['check_in'];
    _checkOut = json['check_out'];
    _internet = json['internet'];
    _others = json['others'];
    _roomType = json['room_type'];
    _roomTypeName = json['room_type_name'];
    _rentRoom = json['rent_room'];
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
  String? _contactName;
  String? _contact;
  String? _email;
  String? _address;
  String? _type;
  String? _typeName;
  String? _checkIn;
  String? _checkOut;
  String? _internet;
  String? _others;
  String? _roomType;
  String? _roomTypeName;
  String? _rentRoom;
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
  String? _city_id;

  String? get id => _id;
  String? get city_id => _city_id;
  String? get hostId => _hostId;
  String? get title => _title;
  String? get contactName => _contactName;
  String? get contact => _contact;
  String? get email => _email;
  String? get address => _address;
  String? get type => _type;
  String? get typeName => _typeName;
  String? get checkIn => _checkIn;
  String? get checkOut => _checkOut;
  String? get internet => _internet;
  String? get others => _others;
  String? get roomType => _roomType;
  String? get roomTypeName => _roomTypeName;
  String? get rentRoom => _rentRoom;
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
    map['city_id'] = _city_id;
    map['host_id'] = _hostId;
    map['title'] = _title;
    map['contact_name'] = _contactName;
    map['contact'] = _contact;
    map['email'] = _email;
    map['address'] = _address;
    map['type'] = _type;
    map['type_name'] = _typeName;
    map['check_in'] = _checkIn;
    map['check_out'] = _checkOut;
    map['internet'] = _internet;
    map['others'] = _others;
    map['room_type'] = _roomType;
    map['room_type_name'] = _roomTypeName;
    map['rent_room'] = _rentRoom;
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