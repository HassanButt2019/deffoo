import 'dart:convert';
/// status : true
/// data : [{"id":"1","title":"Laptop charging point","contain":["Yes","No"],"image":"assets/ameneties/Group 52799.png"},{"id":"2","title":"Reading lamp","contain":["Yes","No"],"image":"assets/ameneties/Group 52801.png"},{"id":"3","title":"Fan","contain":["Yes","No"],"image":"assets/ameneties/Group 52802.png"},{"id":"4","title":"AC","contain":["Yes","No"],"image":"assets/ameneties/Group 52803.png"},{"id":"5","title":"Gyser/Hot running water","contain":["Yes","No"],"image":"assets/ameneties/Group 52804.png"},{"id":"7","title":"Private balcony","contain":["Yes","No"],"image":"assets/ameneties/Group 52805.png"},{"id":"8","title":"Smoking allowed","contain":["Yes","No"],"image":"assets/ameneties/Group 52806.png"},{"id":"9","title":"Pet allowed","contain":["Yes","No"],"image":"assets/ameneties/Group 52807.png"},{"id":"10","title":"Garden/lawn","contain":["Yes","No"],"image":"assets/ameneties/Group 52810.png"},{"id":"11","title":"Kids playing area","contain":["Yes","No"],"image":"assets/ameneties/Group 52811.png"},{"id":"12","title":"Swimming pool","contain":["Yes","No"],"image":"assets/ameneties/Group 52812.png"},{"id":"13","title":"Fooding","contain":["Yes","No"],"image":"assets/ameneties/Path 117888.png"},{"id":"14","title":"Laundry","contain":["Yes","No"],"image":"assets/ameneties/Group 52813.png"},{"id":"15","title":"Bon Fire/Camp","contain":["Yes","No"],"image":"assets/ameneties/Group 52813.png"}]
/// group : [{"id":"1","title":"Bedrooms","contain":["Single","Medium","Double"],"image":["assets/ameneties/Group 52815.png","assets/ameneties/Group 52815.png","assets/ameneties/Group 52815.png",null]},{"id":"2","title":"TV","contain":["Cable","Satellite","USB"],"image":["assets/ameneties/Group 52796.png","assets/ameneties/Group 52796.png","assets/ameneties/Group 52796.png",null]},{"id":"3","title":"Room heater","contain":["Electric heater","Bukhari"],"image":["assets/ameneties/Group 52797.png","assets/ameneties/Group 52797.png"]},{"id":"4","title":"Toilet","contain":["Attached","Common"],"image":["assets/ameneties/Group 52798.png","assets/ameneties/Group 52798.png"]},{"id":"5","title":"Hot drinking water facility","contain":["Hot kettle","Hot water with Tharmos"],"image":["assets/ameneties/Group 52809.png","assets/ameneties/Group 52809.png"]}]
/// internet : [{"id":1,"title":"Wifi","image":"assets/ameneties/wifi.png"},{"id":2,"title":"Network available","image":"assets/ameneties/network.png"},{"id":3,"title":"Jio","image":"assets/ameneties/reliance-jio-logo-october-2015-.png"},{"id":4,"title":"Bsnl","image":"assets/ameneties/Bharat_Sanchar_Nigam_Limited-Logo.wine.png"},{"id":5,"title":"Airtel","image":"assets/ameneties/Airtel_logo_logotype_emblem.png"},{"id":6,"title":"VI","image":"assets/ameneties/vi-vodafone-idea.png"}]

AmenitiesModel amenitiesModelFromJson(String str) => AmenitiesModel.fromJson(json.decode(str));
String amenitiesModelToJson(AmenitiesModel data) => json.encode(data.toJson());
class AmenitiesModel {
  AmenitiesModel({
      bool? status, 
      List<Data>? data, 
      List<Group>? group, 
      List<Internet>? internet,}){
    _status = status;
    _data = data;
    _group = group;
    _internet = internet;
}

  AmenitiesModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    if (json['group'] != null) {
      _group = [];
      json['group'].forEach((v) {
        _group?.add(Group.fromJson(v));
      });
    }
    if (json['internet'] != null) {
      _internet = [];
      json['internet'].forEach((v) {
        _internet?.add(Internet.fromJson(v));
      });
    }
  }
  bool? _status;
  List<Data>? _data;
  List<Group>? _group;
  List<Internet>? _internet;

  bool? get status => _status;
  List<Data>? get data => _data;
  List<Group>? get group => _group;
  List<Internet>? get internet => _internet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_group != null) {
      map['group'] = _group?.map((v) => v.toJson()).toList();
    }
    if (_internet != null) {
      map['internet'] = _internet?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// title : "Wifi"
/// image : "assets/ameneties/wifi.png"

Internet internetFromJson(String str) => Internet.fromJson(json.decode(str));
String internetToJson(Internet data) => json.encode(data.toJson());
class Internet {
  Internet({
      int? id, 
      String? title, 
      String? image,}){
    _id = id;
    _title = title;
    _image = image;
}

  Internet.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _image = json['image'];
  }
  int? _id;
  String? _title;
  String? _image;

  int? get id => _id;
  String? get title => _title;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['image'] = _image;
    return map;
  }

}

/// id : "1"
/// title : "Bedrooms"
/// contain : ["Single","Medium","Double"]
/// image : ["assets/ameneties/Group 52815.png","assets/ameneties/Group 52815.png","assets/ameneties/Group 52815.png",null]

Group groupFromJson(String str) => Group.fromJson(json.decode(str));
String groupToJson(Group data) => json.encode(data.toJson());
class Group {
  Group({
      String? id, 
      String? title, 
      List<String>? contain, 
      List<String>? image,}){
    _id = id;
    _title = title;
    _contain = contain;
    _image = image;
}

  Group.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _contain = json['contain'] != null ? json['contain'].cast<String>() : [];
    _image = json['image'] != null ? json['image'].cast<String>() : [];
  }
  String? _id;
  String? _title;
  List<String>? _contain;
  List<String>? _image;

  String? get id => _id;
  String? get title => _title;
  List<String>? get contain => _contain;
  List<String>? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['contain'] = _contain;
    map['image'] = _image;
    return map;
  }

}

/// id : "1"
/// title : "Laptop charging point"
/// contain : ["Yes","No"]
/// image : "assets/ameneties/Group 52799.png"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? title, 
      List<String>? contain, 
      String? image,}){
    _id = id;
    _title = title;
    _contain = contain;
    _image = image;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _contain = json['contain'] != null ? json['contain'].cast<String>() : [];
    _image = json['image'];
  }
  String? _id;
  String? _title;
  List<String>? _contain;
  String? _image;

  String? get id => _id;
  String? get title => _title;
  List<String>? get contain => _contain;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['contain'] = _contain;
    map['image'] = _image;
    return map;
  }

}