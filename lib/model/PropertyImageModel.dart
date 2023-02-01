import 'dart:convert';
/// status : true
/// data : [{"id":"1","property_id":"1","property_image":"property23.jpg","created_at":"2022-02-12 06:37:18"},{"id":"2","property_id":"1","property_image":"property5.jpg","created_at":"2022-02-12 06:37:34"},{"id":"3","property_id":"1","property_image":"property24.jpg","created_at":"2022-02-12 06:37:45"},{"id":"4","property_id":"1","property_image":"11390371.jpg","created_at":"2022-02-12 10:09:47"}]
/// meassge : "Listing Update successfully"
/// path : "https://alphawizztest.tk/Deffo/uploads/property_image"

PropertyImageModel propertyImageModelFromJson(String str) => PropertyImageModel.fromJson(json.decode(str));
String propertyImageModelToJson(PropertyImageModel data) => json.encode(data.toJson());
class PropertyImageModel {
  PropertyImageModel({
      bool? status, 
      List<Data>? data, 
      String? meassge, 
      String? path,}){
    _status = status;
    _data = data;
    _meassge = meassge;
    _path = path;
}

  PropertyImageModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _meassge = json['meassge'];
    _path = json['path'];
  }
  bool? _status;
  List<Data>? _data;
  String? _meassge;
  String? _path;

  bool? get status => _status;
  List<Data>? get data => _data;
  String? get meassge => _meassge;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['meassge'] = _meassge;
    map['path'] = _path;
    return map;
  }

}

/// id : "1"
/// property_id : "1"
/// property_image : "property23.jpg"
/// created_at : "2022-02-12 06:37:18"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? propertyId, 
      String? propertyImage, 
      String? createdAt,}){
    _id = id;
    _propertyId = propertyId;
    _propertyImage = propertyImage;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _propertyId = json['property_id'];
    _propertyImage = json['property_image'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _propertyId;
  String? _propertyImage;
  String? _createdAt;

  String? get id => _id;
  String? get propertyId => _propertyId;
  String? get propertyImage => _propertyImage;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['property_id'] = _propertyId;
    map['property_image'] = _propertyImage;
    map['created_at'] = _createdAt;
    return map;
  }

}
class PropertyImage {
  bool? status;
  Data1? data;
  String? meassge;
  String? path;

  PropertyImage({this.status, this.data, this.meassge, this.path});

  PropertyImage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
    meassge = json['meassge'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['meassge'] = this.meassge;
    data['path'] = this.path;
    return data;
  }
}

class Data1 {
  String? id;
  String? propertyId;
  String? propertyImage;
  String? createdAt;

  Data1({this.id, this.propertyId, this.propertyImage, this.createdAt});

  Data1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    propertyId = json['property_id'];
    propertyImage = json['property_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_id'] = this.propertyId;
    data['property_image'] = this.propertyImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}
