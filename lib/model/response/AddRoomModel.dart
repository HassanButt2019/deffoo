import 'dart:convert';
/// status : true
/// data : []
/// meassge : "Rooms Update successfully"

AddRoomModel addRoomModelFromJson(String str) => AddRoomModel.fromJson(json.decode(str));
String addRoomModelToJson(AddRoomModel data) => json.encode(data.toJson());
class AddRoomModel {
  AddRoomModel({
      bool? status, 

      String? meassge,}){
    _status = status;

    _meassge = meassge;
}

  AddRoomModel.fromJson(dynamic json) {
    _status = json['status'];
    _meassge = json['meassge'];
  }
  bool? _status;

  String? _meassge;

  bool? get status => _status;
  String? get meassge => _meassge;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['meassge'] = _meassge;
    return map;
  }

}