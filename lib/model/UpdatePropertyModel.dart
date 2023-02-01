import 'dart:convert';
/// status : true
/// meassge : ""

UpdatePropertyModel updatePropertyModelFromJson(String str) => UpdatePropertyModel.fromJson(json.decode(str));
String updatePropertyModelToJson(UpdatePropertyModel data) => json.encode(data.toJson());
class UpdatePropertyModel {
  UpdatePropertyModel({
      bool? status, 
      String? meassge,}){
    _status = status;
    _meassge = meassge;
}

  UpdatePropertyModel.fromJson(dynamic json) {
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