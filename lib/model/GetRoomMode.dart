import 'dart:convert';
/// status : true
/// data : [{"id":"2","property_id":"2","bedroom":"[Single, Medium]","tv":"[Cable, Satellite]","room_heater":"0","toilet":"[Attached, Common]","hot_drinking":"[Electric kettle, Hot water with Tharmos]","no_of_room":"4","room_type":"","room_type_name":"demo","rent_room":"500","property_image":"[image_picker9013605503770276928.jpg]","status":"0","creat_date":"0000-00-00 00:00:00"}]
/// path : "http://alphawizztest.tk/uploads/property_image/"
/// meassge : "Listing  successfully"

GetRoomMode getRoomModeFromJson(String str) => GetRoomMode.fromJson(json.decode(str));
String getRoomModeToJson(GetRoomMode data) => json.encode(data.toJson());
class GetRoomMode {
  GetRoomMode({
      bool? status, 
      List<Data>? data, 
      String? path, 
      String? meassge,}){
    _status = status;
    _data = data;
    _path = path;
    _meassge = meassge;
}

  GetRoomMode.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _path = json['path'];
    _meassge = json['meassge'];
  }
  bool? _status;
  List<Data>? _data;
  String? _path;
  String? _meassge;

  bool? get status => _status;
  List<Data>? get data => _data;
  String? get path => _path;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['path'] = _path;
    map['meassge'] = _meassge;
    return map;
  }

}

/// id : "2"
/// property_id : "2"
/// bedroom : "[Single, Medium]"
/// tv : "[Cable, Satellite]"
/// room_heater : "0"
/// toilet : "[Attached, Common]"
/// hot_drinking : "[Electric kettle, Hot water with Tharmos]"
/// no_of_room : "4"
/// room_type : ""
/// room_type_name : "demo"
/// rent_room : "500"
/// property_image : "[image_picker9013605503770276928.jpg]"
/// status : "0"
/// creat_date : "0000-00-00 00:00:00"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? propertyId, 
      String? bedroom, 
      String? tv, 
      String? roomHeater, 
      String? toilet, 
      String? hotDrinking, 
      String? noOfRoom, 
      String? roomType, 
      String? roomTypeName, 
      String? rentRoom, 
      String? propertyImage, 
      String? status, 
      String? creatDate,}){
    _id = id;
    _propertyId = propertyId;
    _bedroom = bedroom;
    _tv = tv;
    _roomHeater = roomHeater;
    _toilet = toilet;
    _hotDrinking = hotDrinking;
    _noOfRoom = noOfRoom;
    _roomType = roomType;
    _roomTypeName = roomTypeName;
    _rentRoom = rentRoom;
    _propertyImage = propertyImage;
    _status = status;
    _creatDate = creatDate;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _propertyId = json['property_id'];
    _bedroom = json['bedroom'];
    _tv = json['tv'];
    _roomHeater = json['room_heater'];
    _toilet = json['toilet'];
    _hotDrinking = json['hot_drinking'];
    _noOfRoom = json['no_of_room'];
    _roomType = json['room_type'];
    _roomTypeName = json['room_type_name'];
    _rentRoom = json['rent_room'];
    _propertyImage = json['property_image'];
    _status = json['status'];
    _creatDate = json['creat_date'];
  }
  String? _id;
  String? _propertyId;
  String? _bedroom;
  String? _tv;
  String? _roomHeater;
  String? _toilet;
  String? _hotDrinking;
  String? _noOfRoom;
  String? _roomType;
  String? _roomTypeName;
  String? _rentRoom;
  String? _propertyImage;
  String? _status;
  String? _creatDate;

  String? get id => _id;
  String? get propertyId => _propertyId;
  String? get bedroom => _bedroom;
  String? get tv => _tv;
  String? get roomHeater => _roomHeater;
  String? get toilet => _toilet;
  String? get hotDrinking => _hotDrinking;
  String? get noOfRoom => _noOfRoom;
  String? get roomType => _roomType;
  String? get roomTypeName => _roomTypeName;
  String? get rentRoom => _rentRoom;
  String? get propertyImage => _propertyImage;
  String? get status => _status;
  String? get creatDate => _creatDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['property_id'] = _propertyId;
    map['bedroom'] = _bedroom;
    map['tv'] = _tv;
    map['room_heater'] = _roomHeater;
    map['toilet'] = _toilet;
    map['hot_drinking'] = _hotDrinking;
    map['no_of_room'] = _noOfRoom;
    map['room_type'] = _roomType;
    map['room_type_name'] = _roomTypeName;
    map['rent_room'] = _rentRoom;
    map['property_image'] = _propertyImage;
    map['status'] = _status;
    map['creat_date'] = _creatDate;
    return map;
  }

}