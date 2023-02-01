import 'dart:convert';
/// status : true
/// data : []
/// meassge : "room Remove  successfully"

RoomDeleteModel roomDeleteModelFromJson(String str) => RoomDeleteModel.fromJson(json.decode(str));
String roomDeleteModelToJson(RoomDeleteModel data) => json.encode(data.toJson());
class RoomDeleteModel {
  RoomDeleteModel({
      bool? status,
      String? meassge,}){
    _status = status;

    _meassge = meassge;
}

  RoomDeleteModel.fromJson(dynamic json) {
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